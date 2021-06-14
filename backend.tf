terraform {
  backend "s3" {
    bucket = "inesh-terraform"
    key = "terraform.tfstate"
    region = "us-east-1"     
  }

}