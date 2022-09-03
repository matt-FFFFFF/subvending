terraform {
  required_version = "~> 1.2.0"
  backend "azurerm" {
    storage_account_name = "tfstatemattfff"
    container_name       = "tfstate"
    key                  = "mattfff.tfstate"
    use_azuread_auth     = true
    subscription_id      = "0a8501c6-55c7-4826-9252-9823c6f839a1"
    tenant_id            = "c180f90e-b05a-4e58-81a2-3f6f7d9340e1"
    use_microsoft_graph  = true
  }
}
