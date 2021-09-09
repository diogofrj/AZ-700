variable "ad_rg" { type = string }
variable "dns_servers" { type = list(string) }
variable "prefix_project" { type = string }
variable "tags" { type = map(any) }

variable "rg_eastus" { type = string }
variable "loc_eastus" { type = string }
variable "rg_eastus2" { type = string }
variable "loc_eastus2" { type = string }
variable "rg_westus" { type = string }
variable "loc_westus" { type = string }
variable "rg_westus2" { type = string }
variable "loc_westus2" { type = string }

variable "onprem_vnet" {  type = string }
variable "onprem_vnet_range" { type = list(string) }
variable "onprem_snet" {  type = string }
variable "onprem_snet_range" { type = list(string) }