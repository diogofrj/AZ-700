resource "azurerm_resource_group" "rg_eastus" {
  name     = "${var.rg_eastus}-${var.prefix_project}"
  location = var.loc_eastus
  tags     = var.tags
}

resource "azurerm_resource_group" "rg_eastus2" {
  name     = "${var.rg_eastus2}-${var.prefix_project}"
  location = var.loc_eastus2
  tags     = var.tags
}

resource "azurerm_resource_group" "rg_westus" {
  name     = "${var.rg_westus}-${var.prefix_project}"
  location = var.loc_westus
  tags     = var.tags
}

resource "azurerm_resource_group" "rg_westus2" {
  name     = "${var.rg_westus2}-${var.prefix_project}"
  location = var.loc_westus2
  tags     = var.tags
}
