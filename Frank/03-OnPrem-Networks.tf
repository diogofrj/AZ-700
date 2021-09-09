

resource "azurerm_virtual_network" "OnPrem_vnet" {
  name                = "${var.onprem_vnet}-${var.prefix_project}"
  location            = var.loc_eastus
  resource_group_name = azurerm_resource_group.rg_eastus.name
  address_space       = var.onprem_vnet_range
 //dns_servers         = var.dns_servers
  tags = var.tags
}

resource "azurerm_subnet" "OnPrem_snet" {
  name                 = "${var.onprem_snet}-${var.prefix_project}"
  resource_group_name  = azurerm_resource_group.rg_eastus.name
  virtual_network_name = azurerm_virtual_network.OnPrem_vnet.name
  address_prefixes     = var.onprem_snet_range

  enforce_private_link_service_network_policies  = true
  enforce_private_link_endpoint_network_policies = true

  //service_endpoints = ["Microsoft.Storage"]
}