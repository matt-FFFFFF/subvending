# locals {
#   hub_networks_by_location = {
#     for _, v in module.alz.azurerm_virtual_network.connectivity :
#     v.location => v
#   }
# }
