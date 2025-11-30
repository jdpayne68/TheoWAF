# Terraform configuration block
# This defines the minimum Terraform version and required providers

terraform {
required_version = ">= 1.0"

required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
 }
}   

terraform {
  backend "s3" {
    bucket = " jp-remote-state-store-11-25-2025"
    key    = "class7/most_desired-ladies/jp/11-25-2025/terraform.tfstate"
    region = "us-east-1" # has to the be region where the S3 bucket is created
  }
}

# AWS Provider configuration
# This tells Terraform how to connect to AWS
provider "aws" {
region = "us-east-1"
profile = "default"

# # Default tags are applied to all resources created by this provider
# default_tags {
# tags = {
# Project = "vpc-demo"
# Environment = "dev"
# ManagedBy = "Terraform"
#

}

