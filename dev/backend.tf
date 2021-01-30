terraform {
      backend "s3" {
      bucket = "anita-terraform"
      key    = "dev1/terraform.tfstate"
      region = "us-east-1"
  }
}