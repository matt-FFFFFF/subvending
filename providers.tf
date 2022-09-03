provider "azurerm" {
  features {}
  subscription_id = "0a8501c6-55c7-4826-9252-9823c6f839a1"
}

provider "azurerm" {
  features {}
  alias = "management"
  subscription_id = "0a8501c6-55c7-4826-9252-9823c6f839a1"
}

provider "azurerm" {
  features {}
  alias = "connectivity"
  subscription_id = "8b0bdc29-f686-4d2b-aa3f-4c2b509af786"
}
