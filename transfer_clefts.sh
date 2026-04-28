#! /bin/bash
igneous image xfer gs://bossdb-v1dd-transfer/v1dd_clefts/ s3://bossdb-open-data/v1deepdive/v1dd_structural/clefts \
    --queue https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample \
    --mip 0 \
    --skip-downsample \
    --sharded \

