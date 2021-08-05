/*
resource "azurerm_network_interface" "nicvmonprem" {
  count               = 1
  name                = "VMOnprem-${count.index}-nic01"
  location            = var.region_onprem
  resource_group_name = azurerm_resource_group.core.name
  ip_configuration {
    name                          = "ipconfig01"
    subnet_id                     = azurerm_subnet.onpremsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pipvmonprem.id
  }
    tags = {
    environment = "AZ700"
  }
}
resource "azurerm_virtual_machine" "TestVMOnprem" {
  count               = 1
  name                = "VMOnprem-${count.index + 1}"
  resource_group_name = azurerm_virtual_network.core.resource_group_name
  location            = var.region_onprem
  network_interface_ids = [
    element(azurerm_network_interface.nicvmonprem.*.id, count.index)
  ]
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
    name          = "VMOnprem-${count.index}-OSDisk"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }
  os_profile {
    computer_name  = "VMOnprem-${count.index}"
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

resource "azurerm_public_ip" "pipvmonprem" {
  name                = "pip-VMOnprem"
  resource_group_name = azurerm_resource_group.core.name
  location            = var.region_onprem
  allocation_method   = "Dynamic"

  tags = {
    environment = "AZ700"
  }
}
*/