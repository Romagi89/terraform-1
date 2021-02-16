terraform {
  backend "s3" {
    bucket = "anita-terraform"
    key    = "test-state/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformfile"
  }
}