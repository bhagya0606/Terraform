terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "6237aac1-188d-4269-8572-ec7bfe4eac33"
}

