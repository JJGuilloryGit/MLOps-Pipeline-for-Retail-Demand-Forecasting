module "networking" {
  source = "./networking"
}

module "s3" {
  source = "./s3"
}

module "msk" {
  source  = "./msk"
  vpc_id  = module.networking.vpc_id
  subnets = module.networking.subnets
}

module "iam" {
  source = "./s3"
}

resource "aws_vpc" "networking" {
  cidr_block           = "10.32.0.0/16"  # Choose your CIDR block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "jenkins-vpc"
  }
}


