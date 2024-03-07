terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
  }
  required_version = "1.4.6"

  backend "s3" {
    encrypt        = true
    bucket         = "stdfalse-tf-state-us-west-1"
    key            = "03-debugging/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "tf-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}
