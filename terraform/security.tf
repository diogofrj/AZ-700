resource "azurerm_network_security_group" "nsgcore" {
  name                = "NSG-700"
  location            = var.region_core
  resource_group_name = azurerm_resource_group.core.name

  security_rule {
    name                       = "LiberaRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "187.67.25.218"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "AZ700"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsgsubnetdb" {
  subnet_id                 = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.nsgcore.id
}