terraform {
  required_version = "~> 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.3.0"
    }
  }
  backend "azurerm" {
    container_name       = "tfstate"
    key                  = "mattfff.tfstate"
    storage_account_name = "tfstatemattfff"
    subscription_id      = "0a8501c6-55c7-4826-9252-9823c6f839a1"
    tenant_id            = "c180f90e-b05a-4e58-81a2-3f6f7d9340e1"
    use_azuread_auth     = true
    use_oidc             = true
  }
}
