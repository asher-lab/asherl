
# --- Required Provider Version ---- #
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# --- Required Terraform Version ---- #
terraform {
  required_version = ">= 0.12"
}

# --- pass D.O. token ---- #
provider "digitalocean" {
  token = var.do_token
}
