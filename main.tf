terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket = "abh-tf-state"
    key    = "${var.app_name}/terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

