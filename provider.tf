terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "b-terraform-fe110210d9a12a538a6373658192f622"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-southeast-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "b-terraform-fe110210d9a12a538a6373658192f622"
    encrypt        = true
  }
}