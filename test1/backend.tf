terraform {
      backend "s3" {
      bucket = "anita-terraform"
      key    = "anita1-state/"
      region = "us-east-1"
      

  }
}