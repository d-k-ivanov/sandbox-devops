#!/usr/bin/env bash

terraform plan -destroy                                 \
    -target module.vpc_ap_east_1_to_ap_northeast_1      \
    -target module.vpc_ap_east_1_to_eu_west_1           \
    -target module.vpc_ap_east_1_to_sa_east_11          \
    -target module.vpc_ap_east_1_to_us_east_1           \
    -target module.vpc_ap_northeast_1_to_ap_east_1      \
    -target module.vpc_ap_northeast_1_to_eu_west_1      \
    -target module.vpc_ap_northeast_1_to_us_east_1      \
    -target module.vpc_ap_northeast_1_to_ap_northeast_1 \
    -target module.vpc_eu_west_1_to_ap_east_1           \
    -target module.vpc_eu_west_1_to_ap_northeast_1      \
    -target module.vpc_eu_west_1_to_sa_east_1           \
    -target module.vpc_eu_west_1_to_us_east_1           \
    -target module.vpc_sa_east_1_to_ap_east_1           \
    -target module.vpc_sa_east_1_to_ap_northeast_1      \
    -target module.vpc_sa_east_1_to_eu_west_1           \
    -target module.vpc_sa_east_1_to_us_east_1           \
    -target module.vpc_us_east_1_to_ap_east_1           \
    -target module.vpc_us_east_1_to_ap_northeast_1      \
    -target module.vpc_us_east_1_to_eu_west_1           \
    -target module.vpc_us_east_1_to_sa_east_1           \
    -out terraform.plan
