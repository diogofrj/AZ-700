# Customized the sample values below for your environment and either rename to terraform.tfvars or env.auto.tfvars

# BEGIN VARs: AMBIENTE EXISTENTE 
ad_rg       = "RG-CURSO-700-ADDS"
dns_servers = ["10.0.0.20", "168.63.129.16"]

prefix_project = "AZ700"
tags = {
  "Ambiente"    = "TagAmbienteAz700"
  "CentroCusto" = "TagCentroCustoAz700"
}

# END VARs: AMBIENTE EXISTENTE

rg_eastus   = "RG-EASTUS"
loc_eastus  = "eastus"
rg_eastus2  = "RG-EASTUS2"
loc_eastus2 = "eastus2"
rg_westus   = "RG-WESTUS"
loc_westus  = "westus"
rg_westus2  = "RG-WESTUS2"
loc_westus2 = "westus2"

onprem_vnet      = "ONPREM-VNETt"
onprem_vnet_range    = ["192.168.0.0/16"]
onprem_snet      = "ONPREM-SUBNET"
onprem_snet_range  = ["192.168.1.0/24"]

