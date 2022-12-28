terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "b-terraform-fe110210d9a12a538a6373658192f622"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "ap-southeast-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "b-terraform-fe110210d9a12a538a6373658192f622"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}