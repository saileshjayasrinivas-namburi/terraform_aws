terraform {
  backend "s3" {
    bucket         = "sailesh-tfstate-dev"  
    key            = "terraform/state/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "sailesh-tfstate-lock-dev"
    encrypt        = true
  }
}