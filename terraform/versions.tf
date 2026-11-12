terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Configure a remote backend (e.g. S3 + DynamoDB lock) for real use.
}

provider "aws" {
  region = var.region
}
