# downsample bbox
# https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/6133779826475008


# first create a subset of the data with no downsampling, but with the same encoding settings as the downsampled data. This will allow us to compare the downsampled data to the original data with the same encoding settings, 
# and isolate the effects of downsampling from the effects of encoding.
# encoding level 90
# igneous image xfer s3://bossdb-open-data/v1deepdive/v1dd_structural/em s3://bossdb-open-data/v1deepdive/downsample_test/raw \
#     --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
#     --mip 1 \
#     --bounds-mip 1 \
#     --fill-missing \
#     --skip-downsample \
#     --cutout \
#     --xrange 33024,98560 \
#     --yrange 33408,98944 \
#     --zrange 4688,4944 \
#     --shape 65536,65536,256 \
#     --sharded \


igneous image downsample s3://bossdb-open-data/v1deepdive/downsample_test/jpegxl_quality90 \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --num-mips 4 \
    --sharded \
    --encoding jpegxl \
    --encoding-effort 5 \
    --encoding-level 90

igneous image downsample s3://bossdb-open-data/v1deepdive/downsample_test/jpegxl_quality95 \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --num-mips 4 \
    --sharded \
    --encoding jpegxl \
    --encoding-effort 5 \
    --encoding-level 95


igneous image downsample s3://bossdb-open-data/v1deepdive/downsample_test/jpegxl_quality100 \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --num-mips 4 \
    --sharded \
    --encoding jpegxl \
    --encoding-effort 5 \
    --encoding-level 100

igneous image downsample s3://bossdb-open-data/v1deepdive/downsample_test/raw \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --num-mips 4 \
    --sharded \
    --encoding raw \