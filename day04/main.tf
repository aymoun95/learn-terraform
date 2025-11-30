terraform {

  backend "s3" {
    bucket                      = "aymen-terraform"
    key                         = "dev/terraform.tfstate"
    region                      = "us-east-1"
    encrypt                     = true
    use_lockfile                = true
    endpoints                   = { s3 = "http://s3.localhost.localstack.cloud:4566" }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }



}

# Configure the AWS Provider
provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"

  # only required for non virtual hosted-style endpoint use case.
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#s3_force_path_style
  s3_use_path_style           = false
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3        = "http://s3.localhost.localstack.cloud:4566"
    sts       = "http://localhost:4566"
    s3control = "http://localhost:4566"
  }
}




# Create s3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "aymen-terraform-create-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
