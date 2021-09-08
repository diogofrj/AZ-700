#*********************************************************************************************
# Responsável: 
#*********************************************************************************************
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.75.0"
    }
  }
  /*
  backend "remote" {
    organization = "4MSTech-dfernandes"
    workspaces {
      name = "avd-terraform-templates"
      prefix = "adds"
    }
  }
  */
  required_version = ">= 1.0.0"
}

provider "random" {}

provider "azurerm" {
  features {}
  //alias           = "MCT"
  subscription_id = "d2f93f5a-ec21-4898-b14e-db4995d3b147"
  tenant_id       = "5111b6c6-d49c-4f30-ae94-f32f6a0e053c"
}

# CALL MODULES
