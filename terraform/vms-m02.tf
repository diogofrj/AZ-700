# VM CoreServicesTestVM
resource "azurerm_network_interface" "coretestvmnic" {
  name                = "CoreServicesTestVM-nic01"
  location            = var.region_core
  resource_group_name = azurerm_resource_group.core.name
  ip_configuration {
    name                          = "ipconfig01"
    subnet_id                     = azurerm_subnet.db.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pipcore.id
  }

}
resource "azurerm_public_ip" "pipcore" {
  name                = "CoreServicesTestVM-pip"
  resource_group_name = azurerm_resource_group.core.name
  location            = var.region_core
  allocation_method   = "Dynamic"

  tags = {
    environment = "AZ700"
  }
}

resource "azurerm_virtual_machine" "CoreServicesTestVM" {
  name                          = "CoreServicesTestVM"
  resource_group_name           = azurerm_virtual_network.core.resource_group_name
  location                      = var.region_core
  network_interface_ids         = [azurerm_network_interface.coretestvmnic.id]
  vm_size                       = "Standard_B2MS"
  delete_os_disk_on_termination = true
  license_type                  = "Windows_Client"


  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "21h1-ent"
    version   = "latest"
  }
  storage_os_disk {
    name          = "CoreServicesTestVM-OSDisk"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }
  os_profile {
    computer_name  = "CoreServVM"
    admin_username = "localroot"
    admin_password = "Password1234!"
  }
  os_profile_windows_config {
    timezone = "E. South America Standard Time"
  }
  tags = {
    environment = "AZ700"
  }
}



# VM ManufactoringTestVM
resource "azurerm_network_interface" "manufactnic" {
  name                = "vmmanufact-nic01"
  location            = var.region_fabric
  resource_group_name = azurerm_resource_group.core.name
  ip_configuration {
    name                          = "ipconfig01"
    subnet_id                     = azurerm_subnet.submanufact.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pipfactory.id
  }
}
resource "azurerm_public_ip" "pipfactory" {
  name                = "CoreServicesTestVM-pip"
  resource_group_name = azurerm_resource_group.core.name
  location            = var.region_fabric
  allocation_method   = "Dynamic"

  tags = {
    environment = "AZ700"
  }
}

resource "azurerm_virtual_machine" "ManufacturingTestVM" {
  name                          = "ManufacturingTestVM"
  resource_group_name           = azurerm_virtual_network.core.resource_group_name
  location                      = var.region_core
  network_interface_ids         = [azurerm_network_interface.manufactnic.id]
  vm_size                       = "Standard_B2MS"
  delete_os_disk_on_termination = true
  license_type                  = "Windows_Client"


  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "21h1-ent"
    version   = "latest"
  }
  storage_os_disk {
    name          = "CoreServicesTestVM-OSDisk"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }
  os_profile {
    computer_name  = "CoreServVM"
    admin_username = "localroot"
    admin_password = "Password1234!"
  }
  os_profile_windows_config {
    timezone = "E. South America Standard Time"
  }
  tags = {
    environment = "AZ700"
  }
}

# OUTPUTS  
output "PIP-CoreServicesTestVM" {
  value       = azurerm_network_interface.coretestvmnic.ip_configuration
  description = "Projeto Bootcamp"
}

output "PIP-ManufacturingTestVM" {
  value       = azurerm_network_interface.manufactnic.ip_configuration
  description = "Projeto Bootcamp"
}
