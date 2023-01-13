# The landing zone module will be called once per landing_zone_*.yaml file
# in the data directory.
module "lz_vending" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.1" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints
  for_each = local.landing_zone_data_map

  location = each.value.location

  # subscription variables
  subscription_alias_enabled = true
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/7690848/enrollmentAccounts/${each.value.billing_enrollment_account}"
  subscription_display_name  = each.value.name
  subscription_alias_name    = each.value.name
  subscription_workload      = each.value.workload

  # management group association variables
  subscription_management_group_association_enabled = true
  subscription_management_group_id                  = each.value.management_group_id

  # virtual network variables
  virtual_network_enabled = true
  virtual_networks = {
    for k, v in each.value.virtual_networks : k => merge(
      v,
      {
        hub_network_resource_id = local.hub_networks_by_location[each.value.location]
        hub_peering_use_remote_gateways = false
      }
    )
  }
}
