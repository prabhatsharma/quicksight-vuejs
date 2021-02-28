#!/bin/bash


# clear the temp pubic directory
rm -rf dist

echo "Generating build"
# Generate static website. Files will be placed in public folder
npm run build

echo "Deploying to s3"
# Move the files to S3 bucket for hosting
aws s3 sync ./dist s3://aws-quicksight-lambda-go/ --acl=public-read --profile=personal

echo "Invalidating cloudfront cache"
# invalidate cloudfront cache so that latest files can be served
aws cloudfront create-invalidation --distribution-id EQX2OGJOML3D7 --paths=/* --profile=personal
#  https://d7u8ik9wnb4j4.cloudfront.net


