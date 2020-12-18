provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}  

terraform {
  backend "s3" {
    # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "bucket-terraform-guto"
    #dynamodb_table = "terraform-state-lock-dynamo" //Especificação da base NoSQL Dynamo para gerenciar lock de state
    key    = "terraform-guto.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}