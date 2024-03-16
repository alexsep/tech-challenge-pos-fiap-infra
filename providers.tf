terraform {
    required_version = ">=1.7.5"
  required_providers {
    aws = ">=5.41.0"
    local = ">=2.5.1"
  }
}

provider "aws" {
    region = "us-east-1"
}