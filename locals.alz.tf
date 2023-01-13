locals {
  hub_networks_by_location = {
    for k, v in module.alz.azurerm_virtual_network.connectivity :
    v.location => k
  }
}
