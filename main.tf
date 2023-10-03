terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "apache_url_redirection_loops_detected" {
  source    = "./modules/apache_url_redirection_loops_detected"

  providers = {
    shoreline = shoreline
  }
}