terraform {
    backend "s3" {
        bucket = "descomplicando-terraform-rany"
        key    = "giropops-terraform-state"
        region = "us-east-1"
      
    }
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = "~> 2.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}