terraform {
  backend "s3" {
    bucket = "terraform-state-evertonhls"
    key    = "Prod/terraform.tfstate"
    region = "us-west-2"
  }
}
