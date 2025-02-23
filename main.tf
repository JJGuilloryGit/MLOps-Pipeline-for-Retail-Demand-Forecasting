provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "mlops/main.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

module "networking" {
  source  = "./networking"
}

module "eks" {
  source  = "./eks"
  vpc_id  = module.networking.vpc_id
  subnets = module.networking.subnets
}

module "s3" {
  source = "./s3"
}

module "msk" {
  source  = "./msk"
  vpc_id  = module.networking.vpc_id
  subnets = module.networking.subnets
}
