terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "move-itm-iac"
    key = "itm-iac-state.tfstate"
    region = "us-east-1"
    # profile = "itm" // Only to local
  }
  # backend "local" {
  #   path = "/Users/john.moreno/Repos/terraform/resources/itm-iac-state.tfstate"
  # }
}

# Configure for AWS
provider "aws" {
  region = "${var.aws_region}"
  # profile = "${var.aws_profile}" // Only to local
}