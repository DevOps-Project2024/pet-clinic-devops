provider "aws" {
  region = "eu-west-3"
  profile = "dst"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }

  backend "s3" {
    bucket = "petclinic"
    profile = "dst"
    key    = "tfstatefiles/terraform.tfstate"
    region = "eu-west-3"
  }

  required_version = "~> 1.3"
}
