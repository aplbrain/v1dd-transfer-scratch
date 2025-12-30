# sample bounding box 
# https://neuroglancer.bossdb.io/#!https://bossdb-neuvue-datalake.s3.amazonaws.com/public/states/3ebbe106-6d97-491b-af43-51b0b63a8c46.json


# test if cloudfiles hack works
# these bounds should move 16 chunks total
igneous image xfer gs://bossdb-v1dd-transfer/image/aligned_image gs://bossdb-v1dd-transfer/transfer/v1dd_test \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 1 \
    --bounds-mip 1 \
    --skip-downsample \ 
    --cutout \ 
    --xrange 33024,33536 \
    --yrange 33472,33984 \
    --zrange 4688,4704 
