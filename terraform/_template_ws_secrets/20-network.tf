############################## EU-WEST-1 (Ireland) ################################
module "vpc_eu_west_1" {
    source                  = "./modules/vpc"
    region                  = "eu-west-1"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
}

############################## US-EAST-1 (N. Virginia) ############################
module "vpc_us_east_1" {
    source                  = "./modules/vpc"
    region                  = "us-east-1"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
}

############################## AP-NORTHEAST-1 (Tokyo) #############################
module "vpc_ap_northeast_1" {
    source                  = "./modules/vpc"
    region                  = "ap-northeast-1"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
}

############################## AP-EAST-1 (Hong Kong) ##############################
module "vpc_ap_east_1" {
    source                  = "./modules/vpc"
    region                  = "ap-east-1"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
}

############################## SA-EAST-1 (Sao Paolo) ##############################
module "vpc_sa_east_1" {
    source                  = "./modules/vpc"
    region                  = "sa-east-1"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
}
############################## US-WEST-1 (Northern California) ####################
module "vpc_us_west_1" {
    source                  = "./modules/vpc"
    region                  = "us-west-1"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
}

############################## DNS Zone ###########################################
# module "dns_zone" {
#     source          = "./modules/dns_zone"
#     region          = "eu-west-1"
#     aws_access_key  = local.secrets["aws_access_key"]
#     aws_secret_key  = local.secrets["aws_secret_key"]
#     environment     = local.workspace["environment"]
#     project_name    = local.workspace["project_name"]
#     domain_name     = local.workspace["domain_name"]
#     vpc_main        = module.vpc_eu_west_1.vpc_id
#     vpc_others      = [
#         module.vpc_us_east_1.vpc_id,
#         module.vpc_us_west_1.vpc_id,
#         module.vpc_ap_northeast_1.vpc_id,
#         module.vpc_ap_east_1.vpc_id,
#         module.vpc_sa_east_1.vpc_id
#     ]
# }

# ############################## PEERING MESH #####################################
# TODO: Reserach the way to iterate through existed modules.
# locals {
#     # flatten ensures that this local value is a flat list of objects, rather
#     # than a list of lists of objects.
#     vpc_all = toset([
#         [ module.vpc_ap_east_1.vpc_id,      module.vpc_ap_east_1.region      ],
#         [ module.vpc_ap_northeast_1.vpc_id, module.vpc_ap_northeast_1.region ],
#         [ module.vpc_eu_west_1.vpc_id,      module.vpc_eu_west_1.region      ],
#         [ module.vpc_sa_east_1.vpc_id,      module.vpc_sa_east_1.region      ],
#         [ module.vpc_us_east_1.vpc_id,      module.vpc_us_east_1.region      ]
#     ])
#
#
#     vpc_peering_set = flatten([
#         for vpc_this in local.vpc_all : [
#             for vpc_peer in local.vpc_all : {
#                     provider_this   = provider "aws" {
#             alias                   = "this"
#             region                  = each.key.region_this
#             access_key              = var.aws_access_key
#             secret_key              = var.aws_secret_key
#         }
#                     region_this     = vpc_this[1]
#                     region_peer     = vpc_peer[1]
#                     vpc_this        = vpc_this[0]
#                     vpc_peer        = vpc_peer[0]
#
#             } if vpc_this[0] != vpc_peer[0]
#         ]
#     ])
# }

############################## PEERING: EU-WEST-1 (Ireland) #######################
module "vpc_eu_west_1_to_us_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_eu_west_1.region
    aws_region_peer         = module.vpc_us_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_eu_west_1.vpc_id
    peer_vpc_id             = module.vpc_us_east_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_eu_west_1_to_us_west_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_eu_west_1.region
    aws_region_peer         = module.vpc_us_west_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_eu_west_1.vpc_id
    peer_vpc_id             = module.vpc_us_west_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_eu_west_1_to_ap_northeast_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_eu_west_1.region
    aws_region_peer         = module.vpc_ap_northeast_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_eu_west_1.vpc_id
    peer_vpc_id             = module.vpc_ap_northeast_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_eu_west_1_to_ap_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_eu_west_1.region
    aws_region_peer         = module.vpc_ap_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_eu_west_1.vpc_id
    peer_vpc_id             = module.vpc_ap_east_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_eu_west_1_to_sa_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_eu_west_1.region
    aws_region_peer         = module.vpc_sa_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_eu_west_1.vpc_id
    peer_vpc_id             = module.vpc_sa_east_1.vpc_id
    auto_accept_peering     = true
}

############################## PEERING: US-EAST-1 (N. Virginia) ###################
module "vpc_us_east_1_to_us_west_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_us_east_1.region
    aws_region_peer         = module.vpc_us_west_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_us_east_1.vpc_id
    peer_vpc_id             = module.vpc_us_west_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_us_east_1_to_ap_northeast_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_us_east_1.region
    aws_region_peer         = module.vpc_ap_northeast_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_us_east_1.vpc_id
    peer_vpc_id             = module.vpc_ap_northeast_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_us_east_1_to_ap_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_us_east_1.region
    aws_region_peer         = module.vpc_ap_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_us_east_1.vpc_id
    peer_vpc_id             = module.vpc_ap_east_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_us_east_1_to_sa_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_us_east_1.region
    aws_region_peer         = module.vpc_sa_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_us_east_1.vpc_id
    peer_vpc_id             = module.vpc_sa_east_1.vpc_id
    auto_accept_peering     = true
}

############################## PEERING: US-WEST-1 (N. California) ###################
module "vpc_us_west_1_to_ap_northeast_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_us_west_1.region
    aws_region_peer         = module.vpc_ap_northeast_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_us_west_1.vpc_id
    peer_vpc_id             = module.vpc_ap_northeast_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_us_west_1_to_ap_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_us_west_1.region
    aws_region_peer         = module.vpc_ap_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_us_west_1.vpc_id
    peer_vpc_id             = module.vpc_ap_east_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_us_west_1_to_sa_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_us_west_1.region
    aws_region_peer         = module.vpc_sa_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_us_west_1.vpc_id
    peer_vpc_id             = module.vpc_sa_east_1.vpc_id
    auto_accept_peering     = true
}

############################# PEERING: AP-NORTHEAST-1 (Tokyo) ####################
module "vpc_ap_northeast_1_to_ap_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_ap_northeast_1.region
    aws_region_peer         = module.vpc_ap_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_ap_northeast_1.vpc_id
    peer_vpc_id             = module.vpc_ap_east_1.vpc_id
    auto_accept_peering     = true
}

module "vpc_ap_northeast_1_to_sa_east_1" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_ap_northeast_1.region
    aws_region_peer         = module.vpc_sa_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_ap_northeast_1.vpc_id
    peer_vpc_id             = module.vpc_sa_east_1.vpc_id
    auto_accept_peering     = true
}

############################# PEERING: AP-EAST-1 (Hong Kong) #####################

module "vpc_ap_east_1_to_sa_east_11" {
    source                  = "./modules/vpc_peering"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    aws_region_this         = module.vpc_ap_east_1.region
    aws_region_peer         = module.vpc_sa_east_1.region
    environment             = local.workspace["environment"]
    project_name            = local.workspace["project_name"]
    this_vpc_id             = module.vpc_ap_east_1.vpc_id
    peer_vpc_id             = module.vpc_sa_east_1.vpc_id
    auto_accept_peering     = true
}
