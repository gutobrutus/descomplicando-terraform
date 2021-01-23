provider "aws" {
  region = "us-east-1"
  #abaixo um exemplo de interpolação, definindo regiões diferentes, de acordo com o workspace
  #region = "${terraform.workspace} == "production" ? "us-east-1" : "us-east-2""
}

provider "aws" {
  alias = "west"
  region = "us-west-2"
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