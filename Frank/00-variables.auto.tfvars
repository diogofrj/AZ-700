# Customized the sample values below for your environment and either rename to terraform.tfvars or env.auto.tfvars

# BEGIN VARs: AMBIENTE EXISTENTE 
ad_rg       = "RG-CURSO-700-ADDS"
dns_servers = ["10.0.0.20", "168.63.129.16"]

# END VARs: AMBIENTE EXISTENTE

rg_eastus       = "RG-700-EASTUS"
loc_eastus       = "eastus"
rg_eastus2      = "RG-700-EASTUS2"
loc_eastus2       = "eastus2"
rg_westus       = "RG-700-WESTUS"
loc_westus       = "westus"
rg_westus2      = "RG-700-WESTUS2"
loc_westus2       = "westus2"

prefix_project  = "700"
tags = {
  "Ambiente"    = "TagAmbienteAz700"
  "CentroCusto" = "TagCentroCustoAz700"
}