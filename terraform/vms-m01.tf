/*
resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "${var.prefix}-${count.index}-nic01"
  location            = var.region_core
  resource_group_name = azurerm_resource_group.core.name
  ip_configuration {
    name                          = "ipconfig01"
    subnet_id                     = azurerm_subnet.db.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = element(azurerm_public_ip.pipcore.*.id, count.index)
  }
}
resource "azurerm_public_ip" "pipcore" {
  count = 2
  name                = "pip-${var.prefix}-${count.index}"
  resource_group_name = azurerm_resource_group.core.name
  location            = var.region_core
  allocation_method   = "Dynamic"

  tags = {
    environment = "AZ700"
  }
}

resource "azurerm_virtual_machine" "TestVM" {
  count               = 2
  name                = "${var.prefix}-${count.index + 1}"
  resource_group_name = azurerm_virtual_network.core.resource_group_name
  location            = var.region_core
  network_interface_ids = [
    element(azurerm_network_interface.nic.*.id, count.index)
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
    name          = "${var.prefix}-${count.index}-OSDisk"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }
  os_profile {
    computer_name  = "${var.prefix}-${count.index}"
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

*/