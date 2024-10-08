# Llambda

- [Description](#description)
- [Requirements](#requirements)
    - [Local](#local)
    - [AWS](#aws)
- [Getting started](#getting-started)
    - [Configuration](#configuration)
    - [Setup](#setup)
    - [Usage](#usage)
- [References](#references)

## Description
This sample project aims to show the possibility of deploying serverless generative AI on AWS at a very low cost.

The main idea is to deploy a container with an endpoint on a Lambda function to interact with the model.

## Requirements

### Local
You need to have installed:
- Docker;
- AWS CLI;
- Make.

### AWS
Make sure you have created:
- an ECR repository.

## Getting started

### Configuration
Create the `.env` file from the `.env.dist` file and update it with:
- `ECR`: the ECR registry;
- `REPOSITORY`: the ECR repository;
- `MODEL_URL`: the download url of a model in GGUF format (https://huggingface.co/models?library=gguf);

Note that the size of the model should be not a little less than the memory limit of the lambda, which is about 10 GB at most.

### Setup

1. Build and push the image to the registry.

    Download the model:
    ```sh
    make download
    ```
    Build the container image and tag it:
    ```sh
    make build
    ```
    ```sh
    make tag
    ```
    Login into ECR:
    ```sh
    make ecr-login
    ```
    Push the image:
    ```sh
    make push
    ```

2. Create a Lambda function with your repository.
    
    Make sure to:
    - set the maximum available memory;
    - enable function URL;
    - increase the timeout if necessary;

### Usage
Make a request to the function endpoint to get the model response:
```
curl "https://{LAMBDA_FUNCTION_URL}/prompt?text=hello"
```

## References
[OpenLLaMa on AWS Lambda](https://github.com/baileytec-labs/llama-on-lambda)
