data "azurerm_client_config" "core" {
  provider = azurerm
}

data "azurerm_client_config" "management" {
  provider = azurerm.management
}

data "azurerm_client_config" "connectivity" {
  provider = azurerm.connectivity
}


module "alz" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "= 3.1.2"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name

  deploy_corp_landing_zones   = true
  deploy_online_landing_zones = true

  default_location = "northeurope"

  disable_telemetry = true

  // Set subscription IDs for placement of platform subs
  subscription_id_management   = data.azurerm_client_config.management.subscription_id
  subscription_id_connectivity = data.azurerm_client_config.connectivity.subscription_id
  #subscription_id_identity     = "2e4e0f6e-2391-498f-8f0f-ae54960cb44f"

  // Use management group association instead of having to be explicit about MG membership
  strict_subscription_association = false

  // Management resources
  deploy_management_resources = true
  configure_management_resources = {
    settings = {
      log_analytics = {
        enabled = true
      }
      security_center = {
        config = {
          email_security_contact = "admin@mattfff.onmicrosoft.com"
        }
        enabled = true
      }
    }
    tags = null
  }

  // Connectivity (hub network) configuration
  deploy_connectivity_resources = false
  configure_connectivity_resources = {
    settings = {
      ddos_protection_plan = {
        enabled = false
      }
      dns = {
        enabled = false
      }
      hub_networks = [{
        config = {
          address_space = ["10.0.0.0/23"]
          azure_firewall = {
            enabled = false
          }
          subnets = [{
            address_prefixes = ["10.0.0.0/24"]
            name             = "default"
          }]
          virtual_network_gateway = {
            enabled = false
          }
        }
        enabled = true
      }]
    }
    tags = null
  }
}
