terraform {
  backend "s3" {
    bucket = "terraform-state-evertonhls"
    key    = "Homolog/terraform.tfstate"
    region = "us-east-2"
  }
}
