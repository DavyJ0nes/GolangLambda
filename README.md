[![Go Report Card](https://goreportcard.com/badge/github.com/DavyJ0nes/GolangLambda)](https://goreportcard.com/report/github.com/DavyJ0nes/GolangLambda)
# Golang Lambda

## Description
This repo illustrates how to use a Golang binary within a AWS Lambda function.

The flow of the program is simply that a NodeJS lambda function forks its process to run the Golang program as a child, while feeding in the functions event as a json object.

In this example the event is an SNS Message but this can be extended to accept any event type.

## Usage:

```shell
#---------- TESTING ----------#
## Generate test event for use with SAM Local CLI
make generate-event

## Test the function using SAM Local CLI
make test

#---------- DEPLOYING ----------#
# Package the function for deployment with Cloudformation
make package s3_bucket=NAME_OF_S3_BUCKET s3_dir=NAME_OF_BUCKET_DIRECTORY

# Deploy the function using Cloudformation
make deploy s3_bucket=NAME_OF_S3_BUCKET s3_dir=NAME_OF_BUCKET_DIRECTORY stack_name=NAME_TO_USE_FOR_CLOUDFORMATION_STACK
```

## Requirements
- [Docker](https://docs.docker.com/engine/installation)
- [AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- [SAM Local CLI](https://github.com/awslabs/aws-sam-local)

## License
MIT
