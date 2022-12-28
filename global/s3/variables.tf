variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default     = "b-terraform-fe110210d9a12a538a6373658192f622"
}

variable "table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = "b-terraform-fe110210d9a12a538a6373658192f622"
}