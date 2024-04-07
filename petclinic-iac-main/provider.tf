provider "aws" {
  access_key = "AKIAW6SWDCMUBNO2NRSP"
  secret_key = "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"
 	region = "eu-west-3"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }

  backend "s3" {
    bucket = "petclinic2024"
    key    = "tfstatefiles/terraform.tfstate"
    region = "eu-west-3"
  }

  required_version = "~> 1.3"
}
