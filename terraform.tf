terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }

    tfe = {
      version = "~> 0.53.0"
    }
  }
}