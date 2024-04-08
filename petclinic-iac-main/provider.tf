provider "aws" {
  region = "eu-west-3"
  profile = "student35_jan24_bootcamp_devops_petclinic"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }

  backend "s3" {
    bucket = "petclinic-devops"
    profile = "student35_jan24_bootcamp_devops_petclinic"
    key    = "tfstatefiles/terraform.tfstate"
    region = "eu-west-3"
  }

  required_version = "~> 1.3"
}
