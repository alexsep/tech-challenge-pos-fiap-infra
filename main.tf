terraform {
    required_version = ">=1.7.5"
  required_providers {
    aws = ">=5.41.0"
    local = ">=2.5.1"
  }
  backend "s3" {
    bucket = "techchallenge-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}

module "vpc-module" {
  source = "./modules/vpc"
  prefix = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
}

module "eks-module" {
    source = "./modules/eks"
    prefix = var.prefix
    vpc_id = module.vpc-module.vpc_id
    cluster_name = var.cluster_name
    log_retention_days = var.log_retention_days
    subnet_ids = module.vpc-module.subnet_ids
    desired_size = var.desired_size
    max_size = var.max_size
    min_size = var.min_size
}