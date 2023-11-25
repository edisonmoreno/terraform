terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "local" {
    path = "/Users/john.moreno/Repos/terraform/resources/itm-iac-state.tfstate"
  }
}

# Configure for AWS
provider "aws" {
  region = "${var.aws_region}"
  # profile = "${var.aws_profile}" // Only to local
}