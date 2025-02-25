provider "aws" {
  region  = "us-east-1"
  profile = "jjguilloryuser1"
}

terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket         = "awsaibucket1"
    key            = "mlops/main.tfstate"
    region         = "us-east-1"
    profile        = "jjguilloryuser1"
    encrypt        = true
  }
}
