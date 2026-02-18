#!/usr/bin/env python3
"""
flip_fill_missing.py

Scan a directory of JSON files and set any "fill_missing": false -> true.
Uses joblib for parallel processing and atomic writes.

Usage:
    python flip_fill_missing.py /path/to/json_dir --jobs -1 --backup
    python flip_fill_missing.py /path/to/json_dir --output /path/to/outdir --jobs 8
"""

import argparse
import json
import os
import tempfile
from pathlib import Path
from joblib import Parallel, delayed
from tqdm import tqdm
import shutil
import sys
from typing import Any

def set_fill_missing_recursively(obj: Any) -> bool:
    """
    Walks obj (which can be dict/list/other) and sets any 'fill_missing' keys
    to True. Returns True if a change was made, else False.
    """
    changed = False
    if isinstance(obj, dict):
        # If key exists and isn't True already, set it
        if 'fill_missing' in obj:
            # Only change when value is exactly False (boolean)
            if obj['fill_missing'] is False:
                obj['fill_missing'] = True
                changed = True
        # Recurse into other values
        for k, v in obj.items():
            # avoid infinite recursion on self-referential structures (JSON won't have them)
            if isinstance(v, (dict, list)):
                if set_fill_missing_recursively(v):
                    changed = True
    elif isinstance(obj, list):
        for i, item in enumerate(obj):
            if isinstance(item, (dict, list)):
                if set_fill_missing_recursively(item):
                    changed = True
    return changed

def process_file(path: Path, inplace: bool = True, out_dir: Path = None, backup: bool = False) -> dict:
    """
    Process a single file. Returns a dict with status info.
    """
    result = {"path": str(path), "changed": False, "error": None, "out_path": None}
    try:
        with path.open('r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        result['error'] = f"load_error: {e}"
        return result

    try:
        changed = set_fill_missing_recursively(data)
    except Exception as e:
        result['error'] = f"traverse_error: {e}"
        return result

    if not changed:
        result['changed'] = False
        # still set out_path if copying to out_dir requested
        if not inplace and out_dir is not None:
            target = out_dir / path.relative_to(path.anchor)
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(path, target)
            result['out_path'] = str(target)
        return result

    # We need to write the modified JSON back
    try:
        if not inplace and out_dir is not None:
            # preserve dir structure under out_dir
            target = out_dir / path.relative_to(path.anchor)
            target.parent.mkdir(parents=True, exist_ok=True)
            write_path = target
        else:
            write_path = path

        # optionally create a backup (only when overwriting original)
        if backup and write_path.exists():
            bak = write_path.with_suffix(write_path.suffix + '.bak')
            shutil.copy2(write_path, bak)

        # atomic write: write to temp file in same dir then replace
        dir_for_temp = write_path.parent
        with tempfile.NamedTemporaryFile('w', encoding='utf-8', delete=False, dir=dir_for_temp) as tf:
            json.dump(data, tf, ensure_ascii=False, indent=2)
            tf.flush()
            tmpname = tf.name
        # os.replace is atomic on POSIX
        os.replace(tmpname, write_path)
        result['changed'] = True
        result['out_path'] = str(write_path)
    except Exception as e:
        result['error'] = f"write_error: {e}"
        # cleanup temp if exists
        try:
            if 'tmpname' in locals() and os.path.exists(tmpname):
                os.remove(tmpname)
        except Exception:
            pass
    return result

def gather_json_files(root: Path):
    # recursive glob for .json files
    return [p for p in root.rglob('*.json') if p.is_file()]

def main():
    parser = argparse.ArgumentParser(description="Set fill_missing -> true in JSON files (parallel).")
    parser.add_argument("dir", type=str, help="Directory containing JSON files (will search recursively).")
    parser.add_argument("--jobs", "-j", type=int, default= -1,
                        help="Number of parallel jobs for joblib. -1 uses all cores.")
    parser.add_argument("--output", "-o", type=str, default=None,
                        help="Optional output directory. If provided, modified files are written there preserving structure. If omitted, files are modified in-place.")
    parser.add_argument("--backup", action="store_true", help="When modifying in-place, create .bak backups before writing.")
    parser.add_argument("--quiet", action="store_true", help="Minimal output.")
    args = parser.parse_args()

    root = Path(args.dir).resolve()
    if not root.exists():
        print("ERROR: directory not found:", root, file=sys.stderr)
        sys.exit(2)

    out_dir = None
    inplace = True
    if args.output:
        out_dir = Path(args.output).resolve()
        out_dir.mkdir(parents=True, exist_ok=True)
        inplace = False

    files = gather_json_files(root)
    total = len(files)
    if total == 0:
        print("No JSON files found under", root)
        return

    if not args.quiet:
        print(f"Found {total} JSON files under {root}. Processing with jobs={args.jobs} ...")

    # Use joblib.Parallel
    worker = delayed(process_file)
    # Wrap generator in list to allow tqdm progress bar
    tasks = (worker(p, inplace=inplace, out_dir=out_dir, backup=args.backup) for p in files)

    # Run in parallel and collect results with progress bar
    results = Parallel(n_jobs=args.jobs, prefer="threads")(tqdm(tasks, total=total))

    # Summarize
    changed_count = sum(1 for r in results if r.get('changed'))
    errors = [r for r in results if r.get('error')]
    if not args.quiet:
        print(f"Completed. Modified: {changed_count}/{total} files.")
        if errors:
            print(f"Errors: {len(errors)} files had errors. See sample below (max 10):")
            for e in errors[:10]:
                print(" -", e['path'], e['error'])
    # Exit status 0 (could extend to non-zero if errors)
    return

if __name__ == "__main__":
    main()
