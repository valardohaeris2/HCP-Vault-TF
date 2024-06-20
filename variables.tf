variable "hvn_id" {
  description = "The ID of the HCP HVN."
  type        = string
  default     = "learn-hcp-vault-hvn"
}

variable "cluster_id" {
  description = "The ID of the HCP Vault cluster."
  type        = string
  default     = "learn-hcp-vault"
}

variable "region" {
  description = "The region of the HCP HVN and Vault cluster."
  type        = string
  default     = "us-west-2"
}

variable "cloud_provider" {
  description = "The cloud provider of the HCP HVN and Vault cluster."
  type        = string
  default     = "aws"
}

variable "tier" {
  description = "Tier of the HCP Vault cluster. Valid options for tiers."
  type        = string
  default     = "dev"
}

variable "resource_share_arn" {
    description = "ARN of the AWS transit gateway"
    type = string
}    

variable "transit_gateway_attachment_id" {
    description = "name of the tgw attachment in the HCP Vault Console"
    type = string
} 

variable "transit_gateway_id" {
    description = "id of the tgw in AWS"
    type = string
}        

variable "route_dest_cidr" {
  description = "CIDR of the AWS VPC to route HVN traffic to in the route table"
  type = string
}
