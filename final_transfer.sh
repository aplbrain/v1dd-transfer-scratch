#! /bin/bash
# Final transfer of aligned_image to jpegxl encoded data in bossdb-v1dd-transfer bucket
igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_jpegxl_quality100 \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --bounds-mip 1 \
    --skip-downsample \
    --cutout \
    --xrange 9148,194497 \
    --yrange 14976,132855 \
    --zrange 0,17664 \
    --shape 185349,117879,17664 \
    --sharded \
    --encoding jpegxl \
    --encoding-effort 5 \
    --encoding-level 90

