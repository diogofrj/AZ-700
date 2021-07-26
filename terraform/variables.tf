variable "prefix" {
  default     = "TestVM"
  description = "Prefix Instances"
}
variable "node_count" {
  default     = "2"
  description = "Count Instances"
}

variable "region_core" {
  default     = "westus"
  description = "Região Core"
}
variable "region_fabric" {
  default     = "northeurope"
  description = "Região Manufacture"
}
variable "region_research" {
  default     = "northindia"
  description = "Região Research"
}