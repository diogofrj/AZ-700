/*
# Data 
data "azurerm_resource_group" "rgaz700" {
  name = "RG-AZ700"
}
output "RG_id" {
  value = data.azurerm_resource_group.rgaz700.id
}
data "azurerm_virtual_network" "CoreUS" {
  name                = "CoreServicesVnet"
  resource_group_name = data.azurerm_resource_group.rgaz700.name
}
output "virtual_network_id" {
  value = data.azurerm_virtual_network.CoreUS.id
}
data "azurerm_subnet" "Database" {
  name                 = "DatabaseSubnet"
  resource_group_name  = data.azurerm_resource_group.rgaz700.name
  virtual_network_name = data.azurerm_virtual_network.CoreUS.name
}
output "virtual_database" {
  value = data.azurerm_subnet.Database.id
}



tdestroy --target=azurerm_virtual_machine.TestVM --target=azurerm_virtual_machine.TestVMOnprem --target=azurerm_public_ip.pipvmonprem --target=azurerm_public_ip.pipcore
*/