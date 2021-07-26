 /*
 resource "azurerm_network_interface" "nic" {
   count = 2  
   name                = "${var.prefix}-${count.index}"
   location            = var.region_core
   resource_group_name = azurerm_resource_group.core.name
 ip_configuration {
     name                          = "internal"
     subnet_id                     = azurerm_subnet.db.id
     private_ip_address_allocation = "Dynamic"
   }
 }
resource "azurerm_virtual_machine" "TestVM" {
  count                 = 2
  name                  = "${var.prefix}+${count.index + 1}"
  resource_group_name   = azurerm_virtual_network.core.resource_group_name
  location              = var.region_core
  network_interface_ids = [
      azurerm_network_interface.nic.*.id[count.index],
      ]
  vm_size               = "Standard_B2MS"
  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "21h1-ent"
    version   = "latest"
  }
  storage_os_disk {
    name          = "${var.prefix}-OSDisk-${count.index}"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }
  os_profile {
    computer_name  = "${var.prefix}+${count.index + 1}"
    admin_username = "localroot"
    admin_password = "Password1234!"
  }
}
*/