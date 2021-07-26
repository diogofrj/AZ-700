

resource "azurerm_resource_group" "core" {
  name     = "AZ-700"
  location = var.region_core
}

resource "azurerm_virtual_network" "core" {
  name                = "CoreServicesVnet-tf"
  address_space       = ["10.20.0.0/16"]
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
}

resource "azurerm_subnet" "gw" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.core.name
  address_prefixes     = ["10.20.0.0/27"]
}
resource "azurerm_subnet" "shared" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.core.name
  address_prefixes     = ["10.20.10.0/24"]
}
resource "azurerm_subnet" "db" {
  name                 = "DatabaseSubnet"
  resource_group_name  = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.core.name
  address_prefixes     = ["10.20.20.0/24"]
}

resource "azurerm_subnet" "web" {
  name                 = "PublicWebServiceSubnet"
  resource_group_name  = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.core.name
  address_prefixes     = ["10.20.30.0/24"]
}

/*
  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
 */ 
