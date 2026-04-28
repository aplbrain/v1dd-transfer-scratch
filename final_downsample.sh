# igneous image downsample s3://bossdb-open-data/v1deepdive/v1dd_structural/em \
#     --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
#     --mip 5 \
#     --num-mips 1 \
#     --sharded \
#     --encoding jpegxl \
#     --encoding-effort 5 \
#     --encoding-level 95 \

# igneous image downsample s3://bossdb-open-data/v1deepdive/v1dd_structural/em \
#     --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
#     --mip 9 \
#     --num-mips 2 \
#     --sharded \
#     --encoding jpegxl \
#     --encoding-effort 5 \
#     --encoding-level 95 \
#     --sparse \
#     --volumetric 

igneous image downsample s3://bossdb-open-data/v1deepdive/v1dd_structural/clefts \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --num-mips 1 \
    --sharded 

igneous image downsample s3://bossdb-open-data/v1deepdive/v1dd_structural/nuclei \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --num-mips 1 \
    --sharded \
    --sparse \
    --volumetric
