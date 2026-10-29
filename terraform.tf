#configure verion of terraform itself and provider in the terraform block

terraform {
  #specifies the required provider
  required_providers {
    aws = {
      source  = "hashicorp/aws" #provider source
      
      #specifies aws provider version
      version = "~> 5.92" #constrained to not install a version of the provider that isnt tested w/ configuration
    }
  }
  #spcifies terraform version to provision infastructure with
  required_version = ">= 1.2"
}
