terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.2.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.89.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
  }
 }
}

provider "vault" {
  address = "https://vault-winterfell........hashicorp.cloud:8200"
}

provider "hcp" {
  client_id     = ""
  client_secret = ""
}

provider "aws" {
  shared_config_files = ["/Users/dev/.aws/config"]
  shared_credentials_files = ["/Users/dev/.aws/credentials"]
  profile = "default"


#=========================================================
#          HCP Vault HVN AWS
#=========================================================

resource "hcp_hvn" "winterfell-vault-hvn" {
  hvn_id         = "winterfell-vault-hvn"
  cloud_provider = "aws"
  region         = "us-east-2"
  cidr_block     = "172.25.16.0/20"
  #   id             = "/project/<project_id>/hashicorp.network.hvn/winterfell-vault-hvn"
  #   organization_id     = ""
  #   project_id          = ""
  #   provider_account_id = ""
  #   self_link           = "/project/<project_id>/hashicorp.network.hvn/winterfell-vault-hvn"
}
# Transit Gateway Attachment 
resource "hcp_aws_transit_gateway_attachment" "winterfell-test-attach" {
  hvn_id                        = var.hvn_id
  resource_share_arn            = var.resource_share_arn
  transit_gateway_attachment_id = var.transit_gateway_attachment_id
  transit_gateway_id            = var.transit_gateway_id
}

# Route 
resource "hcp_hvn_route" "winterfell-test-rtbl" {
    destination_cidr = var.route_dest_cidr
    hvn_link         = "/project/<project_id>/hashicorp.network.hvn/winterfell-vault-hvn"
    hvn_route_id     = "winterfell-test-rtbl"
    target_link      = "/project/<project_id>/hashicorp.network.tgw-attachment/winterfell-test-attach"
}

#===============================================
#           HCP Vault HVN Cluster AWS
#===============================================

resource "hcp_vault_cluster" "vault-winterfell-cluster" {
  hvn_id          = hcp_hvn.winterfell-vault-hvn.hvn_id
  cluster_id      = var.cluster_id
  tier            = var.tier
  public_endpoint = true
}


#=============================================
#          Kv-v2 Secrets Engine
#============================================


# Enable/Mount the kv-v2 backend
resource "vault_mount" "kv-v2" {
 path        = "kv-v2"
 type        = "kv-v2"
 options     = { version = "2" }
 description = "KV Version 2 secret engine mount"
}
