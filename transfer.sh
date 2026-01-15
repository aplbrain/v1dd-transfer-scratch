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
# igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_raw \
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
#     --encoding raw 


# jpegxl level 100
igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_jpegxl_quality100 \
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
    --encoding-effort 10 \
    --encoding-level 100

# jpegxl level 90
# igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_jpegxl_quality90 \
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
#     --encoding-effort 10 \
#     --encoding-level 90

# jpegxl level 50
# igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_jpegxl_quality50 \
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
#     --encoding-effort 10 \
#     --encoding-level 50

# jpegxl level 25
# igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_jpegxl_quality25 \
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
#     --encoding-effort 10 \
#     --encoding-level 25

#png
# igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_png \
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
#     --encoding png 