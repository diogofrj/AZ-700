data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}
data "azuread_client_config" "current" {}

// INFORMAÇÕES SOBRE A IMAGEM EXISTENTE NO AMBIENTE
data "azurerm_image" "img-master" {
  name                = "IMG-CURSOAVD"
  resource_group_name = "RG-CURSO-AVD-IMAGES"
}
output "Managed_image_id" {
  value = data.azurerm_image.img-master.id
}

// INFORMAÇÕES SOBRE A REDE EXISTENTE NO AMBIENTE
data "azurerm_virtual_network" "adavd_vnet" {
  resource_group_name = "RG-CURSO-AVD-ADDS"
  name                = "VNET-CURSO-AVD"
}
data "azurerm_subnet" "adavd_snet" {
  resource_group_name  = "RG-CURSO-AVD-ADDS"
  name                 = "SN-AVD"
  virtual_network_name = "VNET-CURSO-AVD"
}

// INFORMAÇÕES SOBRE O ADDS EXISTENTE NO AMBIENTE

data "azurerm_network_interface" "nic_adds" {
  name = "vm-adds23"

  resource_group_name = "RG-CURSO-AVD-ADDS"
}


data "azurerm_storage_account" "stgcurso" {
  name                = "sacursoavd"
  resource_group_name = "RG-CURSO-AVD-FSLogix"
}
output "storage_id" {
  value = data.azurerm_storage_account.stgcurso.id
}



