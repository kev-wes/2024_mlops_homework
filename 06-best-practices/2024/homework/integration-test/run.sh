#!/usr/bin/env bash

# Define the image name and tag
export LOCAL_IMAGE_NAME="s3-model-duration:latest"

# Build the Docker image
docker build -t ${LOCAL_IMAGE_NAME} ../

# Export environment variables for Docker Compose
export PREDICTIONS_S3_NAME="ride_predictions"
export INPUT_FILE_PATTERN="s3://nyc-duration/in/{year:04d}-{month:02d}.parquet"
export OUTPUT_FILE_PATTERN="s3://nyc-duration/out/{year:04d}-{month:02d}.parquet"
export S3_ENDPOINT_URL="http://localhost:4566"
export DEFAULT_REGION="eu-west-1"
export AWS_ACCESS_KEY_ID="abc"
export AWS_SECRET_ACCESS_KEY="xyz"

docker-compose up -d

sleep 5

aws --endpoint-url=http://localhost:4566 s3 mb s3://nyc-duration

pipenv run python integration_test.py 2023 1

ERROR_CODE=$?

if [ ${ERROR_CODE} != 0 ]; then
    docker-compose logs
    docker-compose down
    exit ${ERROR_CODE}
fi

sleep 5

docker-compose down
