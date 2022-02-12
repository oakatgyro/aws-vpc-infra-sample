# aws-vpc-infra-sample

This is a sample of how to build a vpc and its surrounding services

<!-- ABOUT THE PROJECT -->
## About The Project

Here's why:
I want to communicate my work through Github. This time the first installment of the series.

## Getting Started

This is an example how to build vpc and so on.

### Prerequisites

* jq([Link](https://stedolan.github.io/jq/download/))

    ```sh
    sudo apt-get install jq # Linux sample
    ```

* aws-cli ([Link](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
  
  ```sh
  aws --version
  # show version
  ```

* Setting profile

    Edit your aws profile

    ```conf
    [dev]
    aws_access_key_id = XXXXXXXXX
    aws_secret_access_key = XXXXXXXXX

    [stg]
    aws_access_key_id = XXXXXXXXX
    aws_secret_access_key = XXXXXXXXX

    [prd]
    aws_access_key_id = XXXXXXXXX
    aws_secret_access_key = XXXXXXXXX"
    ```

### Installation

1. Clone the repo

    ```sh
    git clone https://github.com/oakatgyro/aws-vpc-infra-sample.git
    ```

### Usage

1. build

   ```sh
   ./build.sh dev us-east-1
   ```

    | Argument | AllowedValues | Description |
    | ---- | ---- | ---- |
    | env | dev, stg, prd | the envionment |
    | region | us-east-1, eu-west-1, ap-north-east-1 | the region |

2. deploy

    ```sh
   ./build.sh dev us-east-1
   ```

    | Argument | AllowedValues | Description |
    | ---- | ---- | ---- |
    | env | dev, stg, prd | the envionment name |
    | region | us-east-1, eu-west-1, ap-northeast-1 | the region name |

3. check your aws account

## Contact

oakatgyro - @TdHTXeSAeZjE6Tf - oakatgyro@gmail.com

Profile Link: https://github.com/oakatgyro/