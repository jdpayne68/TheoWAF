terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.18.0"
    }
  }
}

provider "aws" {
  # Configuration options

  region = "us-west-2"

  default_tags {
    tags = {
      ManagedBy = "Terraform"
    }
  }
}