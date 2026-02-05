FROM python:3.12
COPY app/* /app/
COPY secrets/* /root/.cloudvolume/secrets/
RUN pip install -r /app/requirements.txt
# override cloud-files to include v1dd-hack changes
RUN pip install "git+https://github.com/aplbrain/cloud-files.git@v1dd-hack"
RUN chmod +x /app/run.sh
WORKDIR /app

# For local testing
#ENV QUEUE=https://sqs.us-east-1.amazonaws.com/407510763690/s3-transfer-downsample
 
CMD ["./run.sh"]