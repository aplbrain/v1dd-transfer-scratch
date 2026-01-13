# sample bounding box 
# https://neuroglancer.bossdb.io/#!https://bossdb-neuvue-datalake.s3.amazonaws.com/public/states/3ebbe106-6d97-491b-af43-51b0b63a8c46.json


# test if cloudfiles hack works
# these bounds should move 20 chunks total
# igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_test \
#     --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
#     --mip 1 \
#     --bounds-mip 1 \
#     --skip-downsample \
#     --cutout \
#     --xrange 33024,33536 \
#     --yrange 33408,34048 \
#     --zrange 4688,4704 \
#     --shape 512,640,16

# test various encoding strategies

# no encoding (raw)
igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_raw \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --bounds-mip 1 \
    --skip-downsample \
    --cutout \
    --xrange 33024,37120 \
    --yrange 33408,35584 \
    --zrange 4688,4944 \
    --shape 4096,2176,256 \
    --sharded \
    --encoding raw 


# jpegxl effort 5
# igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_jpegxl_effort5 \
#     --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
#     --mip 1 \
#     --bounds-mip 1 \
#     --skip-downsample \
#     --cutout \
#     --xrange 33024,37120 \
#     --yrange 33408,35584 \
#     --zrange 4688,4944 \
#     --shape 4096,2176,256 \
#     --sharded \
#     --encoding jpegxl \
#     --encoding-effort 5

# jpegxl effort 1
igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_jpegxl_effort1 \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --bounds-mip 1 \
    --skip-downsample \
    --cutout \
    --xrange 33024,37120 \
    --yrange 33408,35584 \
    --zrange 4688,4944 \
    --shape 4096,2176,256 \
    --sharded \
    --encoding jpegxl \
    --encoding-effort 1

# jpegxl effort 10
igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_jpegxl_effort10 \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --bounds-mip 1 \
    --skip-downsample \
    --cutout \
    --xrange 33024,37120 \
    --yrange 33408,35584 \
    --zrange 4688,4944 \
    --shape 4096,2176,256 \
    --sharded \
    --encoding jpegxl \
    --encoding-effort 10

#png
igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_png \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --bounds-mip 1 \
    --skip-downsample \
    --cutout \
    --xrange 33024,37120 \
    --yrange 33408,35584 \
    --zrange 4688,4944 \
    --shape 4096,2176,256 \
    --sharded \
    --encoding png 