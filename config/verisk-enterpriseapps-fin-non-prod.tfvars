# Copyright (c) 2021 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


##### The uncommented variable assignments below are for REQUIRED variables that do NOT have a default value in variables.tf. They must be provided appropriate values.
##### The commented variable assignments are for variables with a default value in variables.tf. For overriding them, uncomment the variable and provide an appropriate value.


### Tenancy Connectivity
tenancy_ocid         = ""
user_ocid            = ""
fingerprint          = ""
private_key_path     = ""
private_key_password = ""


### Target Region
region        = ""

#  Naming Convention Control Variables
service_label = "EnterpriseApps-Fin-Non-Prod"

use_enclosing_compartment               = true
existing_enclosing_compartment_ocid     = "<OCID for the 'EnterpriseApps-Fin' parent compartment>"
policies_in_root_compartment            = "CREATE"

# use_existing_groups                     = true
existing_iam_admin_group_name           = "<existing_iam_admin_group_name>"
existing_cred_admin_group_name          = "<existing_cred_admin_group_name>"
existing_security_admin_group_name      = "<existing_security_admin_group_name>"
existing_network_admin_group_name       = "<existing_network_admin_group_name>"
existing_appdev_admin_group_name        = "<existing_appdev_admin_group_name>"
existing_database_admin_group_name      = "<existing_database_admin_group_name>"
existing_auditor_group_name             = "<existing_auditor_group_name>"
existing_announcement_reader_group_name = "<existing_announcement_reader_group_name>"
existing_exainfra_admin_group_name      = "<existing_exainfra_admin_group_name>"
existing_cost_admin_group_name          = "<existing_cost_admin_group_name>"


### Networking variables
# vcn_cidrs               = ["10.0.0.0/20","<cidr_2>","...","<cidr_n>"] # list of CIDRs to be used when creating the VCNs. One CIDR to one VCN. Default: ["10.0.0.0/20"].
# vcn_names               = ["<name_1>,"<name_2>","...","<name_n>"] # list of VCN names to override default names with. One name to one CIDR, nth element to vcn_cidrs' nth element.
# is_vcn_onprem_connected = false # determines if the Landing Zone VCN(s) are connected to an on-premises network. This must be true if no_internet_acess is true.
# existing_drg_id         = "" # the OCID of an existing DRG. If provided, no DRG is created even if is_vcn_onprem_connected is checked.
# hub_spoke_architecture  = false # determines if a Hub & Spoke network architecture is to be deployed.  Allows for inter-spoke routing.
# dmz_vcn_cidr            = "<dmz_vcn_cidr>" # IP range in CIDR notation for the DMZ (a.k.a Hub) VCN.
# dmz_number_of_subnets   = 2 # number of subnets in DMZ VCN.
# dmz_subnet_size         = 4 # number of additional bits with which to extend the DMZ VCN CIDR prefix.




### Exadata variables
# exacs_vcn_cidrs           = ["<cidr_1>","<cidr_2>","...","<cidr_n>"] # list of CIDRs to be used when creating the VCNs. One CIDR to one VCN.
# exacs_client_subnet_cidrs = ["<cidr_1>","<cidr_2>","...","<cidr_n>"] # list of CIDR blocks for the client subnets of Exadata Cloud Service VCNs, in CIDR notation. One subnet CIDR to one VCN CIDR, the nth element corresponding to exa_vcn_cidrs' nth element.
# exacs_backup_subnet_cidrs = ["<cidr_1>","<cidr_2>","...","<cidr_n>"] # list of CIDR blocks for the backup subnets of Exadata Cloud Service VCNs, in CIDR notation. One subnet CIDR to one VCN CIDR, the nth element corresponding to exa_vcn_cidrs' nth element.
# exacs_vcn_names           = ["<name_1>","<name_2>","...","<name_n>"] # list of VCN names to override default names with. One name to one VCN CIDR, the nth element corresponding to exa_vcn_cidrs' nth element.
# deploy_exainfra_cmp       = true # whether to deploy a compartment for Exadata infrastructure.




### Network Connectivity variables
# no_internet_access       = false # whether the Landing Zone VCN(s) are Internet connected.
# public_src_lbr_cidrs     = ["<cidr_1>","<cidr_2>","...","<cidr_n>"] # external IP ranges in CIDR notation allowed to make HTTPS inbound connections.
# public_src_bastion_cidrs = ["<cidr_1>","<cidr_2>","...","<cidr_n>"] # external IP ranges in CIDR notation allowed to make SSH inbound connections. 0.0.0.0/0 is not allowed in the list.
# public_dst_cidrs         = ["<cidr_1>","<cidr_2>","...","<cidr_n>"] # external IP ranges in CIDR notation for HTTPS outbound connections.
# onprem_cidrs             = ["<cidr_1>","<cidr_2>","...","<cidr_n>"] # list of on-premises CIDRs that are routeable to Landing Zone networks.
# onprem_src_ssh_cidrs     = ["<cidr_1>","<cidr_2>","...","<cidr_n>"] # list of on-premises CIDRs allowed to connect to Landing Zone networks over SSH. They must be a subset of onprem_cidrs.




### Notifications variables
#network_admin_email_endpoints    = ["<email1>","<e-mail2>","...","<emailn>"] # list of email addresses for all network related notifications.
#security_admin_email_endpoints   = ["<email1>","<e-mail2>","...","<emailn>"] # list of email addresses for all security related notifications.
#compute_admin_email_endpoints    = ["<email1>","<e-mail2>","...","<emailn>"] # list of email addresses for all compute related notifications.
#storage_admin_email_endpoints    = ["<email1>","<e-mail2>","...","<emailn>"] # list of email addresses for all storage related notifications.
#database_admin_email_endpoints   = ["<email1>","<e-mail2>","...","<emailn>"] # list of email addresses for all database related notifications.
#exainfra_admin_email_endpoints   = ["<email1>","<e-mail2>","...","<emailn>"] # list of email addresses for all Exadata infrastrcture related notifications.
#budget_admin_email_endpoints     = ["<email1>","<e-mail2>","...","<emailn>"] # list of email addresses for all budget related notifications.


### Cloud Guard variables
#cloud_guard_configuration_status = "DISABLE"


### Alarm Configuration
# create_alarms_as_enabled = false


### Events Configuration
# create_events_as_enabled = false


### Service Connector Hub variables
# create_service_connector_audit                 = false
# service_connector_audit_target                 = "objectstorage"
# service_connector_audit_state                  = "INACTIVE"
# service_connector_audit_target_OCID            = ""
# service_connector_audit_target_cmpt_OCID       = ""
# sch_audit_objStore_objNamePrefix               = "sch-audit"
# create_service_connector_vcnFlowLogs           = false
# service_connector_vcnFlowLogs_target           = "objectstorage"
# service_connector_vcnFlowLogs_state            = "INACTIVE"
# service_connector_vcnFlowLogs_target_OCID      = ""
# service_connector_vcnFlowLogs_target_cmpt_OCID = ""
# sch_vcnFlowLogs_objStore_objNamePrefix         = "sch-vcnFlowLogs"




### Vulnerability Scanning Service variables
# vss_create        = true
# vss_scan_schedule = "WEEKLY"
# vss_scan_day      = "SUNDAY"


### Cost Management variables
## Percentage of budget amount
#budget_alert_threshold  = 100
## Monthly budget amount
#budget_amount           = 250
## Create a budget at the root or enclosing compartment level, depending on the value of "use_enclosing_compartment"
#create_budget           = true
## List of email addresses for budget related alerts.
#budget_alert_email_endpoints     = ["<email1>","<e-mail2>","...","<emailn>"]
