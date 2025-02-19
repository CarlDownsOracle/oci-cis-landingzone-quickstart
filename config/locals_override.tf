# Copyright (c) 2021 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  ### Discovering the home region name and region key.
  regions_map         = { for r in data.oci_identity_regions.these.regions : r.key => r.name } # All regions indexed by region key.
  regions_map_reverse = { for r in data.oci_identity_regions.these.regions : r.name => r.key } # All regions indexed by region name.
  home_region_key     = data.oci_identity_tenancy.this.home_region_key                         # Home region key obtained from the tenancy data source
  region_key          = lower(local.regions_map_reverse[var.region])                           # Region key obtained from the region name


  ### IAM
  # Default compartment names
  default_enclosing_compartment = {key:"${var.service_label}${local.enclosing_compartment_label}${local.compartment_label}",          name:"${var.service_label}${local.enclosing_compartment_label}${local.compartment_label}"}
  security_compartment          = {key:"${var.service_label}${local.security_label}${local.compartment_label}",     name:"${var.service_label}${local.security_label}${local.compartment_label}"}
  network_compartment           = {key:"${var.service_label}${local.network_label}${local.compartment_label}",      name:"${var.service_label}${local.network_label}${local.compartment_label}"}
  database_compartment          = {key:"${var.service_label}${local.database_label}${local.compartment_label}",     name:"${var.service_label}${local.database_label}${local.compartment_label}"}
  appdev_compartment            = {key:"${var.service_label}${local.appdev_label}${local.compartment_label}",       name:"${var.service_label}${local.appdev_label}${local.compartment_label}"}
  exainfra_compartment          = {key:"${var.service_label}${local.exadata_label}${local.compartment_label}",      name:"${var.service_label}${local.exadata_label}${local.compartment_label}"}

  # Whether compartments should be deleted upon resource destruction.
  enable_cmp_delete = false

  # Whether or not to create an enclosing compartment
  parent_compartment_id         = var.use_enclosing_compartment == true ? (var.existing_enclosing_compartment_ocid != null ? var.existing_enclosing_compartment_ocid : module.lz_top_compartment[0].compartments[local.default_enclosing_compartment.key].id) : var.tenancy_ocid
  parent_compartment_name       = var.use_enclosing_compartment == true ? (var.existing_enclosing_compartment_ocid != null ? data.oci_identity_compartment.existing_enclosing_compartment.name : local.default_enclosing_compartment.name) : "tenancy"
  policy_scope                  = local.parent_compartment_name == "tenancy" ? "tenancy" : "compartment ${local.parent_compartment_name}"
  use_existing_tenancy_policies = var.policies_in_root_compartment == "CREATE" ? false : true

  # Group names
  security_admin_group_name      = var.use_existing_groups == false ? "${var.service_label}${local.security_label}${local.admin_label}${local.group_label}" : data.oci_identity_groups.existing_security_admin_group.groups[0].name
  network_admin_group_name       = var.use_existing_groups == false ? "${var.service_label}${local.network_label}${local.admin_label}${local.group_label}" : data.oci_identity_groups.existing_network_admin_group.groups[0].name
  database_admin_group_name      = var.use_existing_groups == false ? "${var.service_label}${local.database_label}${local.admin_label}${local.group_label}" : data.oci_identity_groups.existing_database_admin_group.groups[0].name
  appdev_admin_group_name        = var.use_existing_groups == false ? "${var.service_label}${local.appdev_label}${local.admin_label}${local.group_label}" : data.oci_identity_groups.existing_appdev_admin_group.groups[0].name
  iam_admin_group_name           = var.use_existing_groups == false ? "${var.service_label}${local.iam_label}${local.admin_label}${local.group_label}" : data.oci_identity_groups.existing_iam_admin_group.groups[0].name
  cred_admin_group_name          = var.use_existing_groups == false ? "${var.service_label}${local.cred_label}${local.admin_label}${local.group_label}" : data.oci_identity_groups.existing_cred_admin_group.groups[0].name
  auditor_group_name             = var.use_existing_groups == false ? "${var.service_label}${local.auditor_label}${local.group_label}" : data.oci_identity_groups.existing_auditor_group.groups[0].name
  announcement_reader_group_name = var.use_existing_groups == false ? "${var.service_label}${local.announce_label}${local.group_label}" : data.oci_identity_groups.existing_announcement_reader_group.groups[0].name
  exainfra_admin_group_name      = var.use_existing_groups == false ? "${var.service_label}${local.exadata_label}${local.admin_label}${local.group_label}" : data.oci_identity_groups.existing_exainfra_admin_group.groups[0].name
  cost_admin_group_name          = var.use_existing_groups == false ? "${var.service_label}${local.cost_label}${local.admin_label}${local.group_label}" : data.oci_identity_groups.existing_cost_admin_group.groups[0].name
  compute_agent_group_name       = "${var.service_label}-appdev-computeagent-dynamic-group"

  # Policy names
  security_admin_policy_name      = "${var.service_label}${local.security_label}${local.admin_label}${local.policy_label}"
  security_admin_root_policy_name = "${var.service_label}${local.security_label}${local.admin_label}${local.root_policy_label}"
  network_admin_policy_name       = "${var.service_label}${local.network_label}${local.admin_label}${local.policy_label}"
  compute_agent_policy_name       = "${var.service_label}${local.compute_label}${local.agent_label}${local.policy_label}"
  network_admin_root_policy_name  = "${var.service_label}${local.network_label}${local.admin_label}${local.root_policy_label}"
  database_admin_policy_name      = "${var.service_label}${local.database_label}${local.admin_label}${local.policy_label}"
  database_dynamic_group_policy_name = "${var.service_label}${local.database_label}${local.dynamic_group_label}${local.policy_label}"
  database_admin_root_policy_name = "${var.service_label}${local.database_label}${local.admin_label}${local.root_policy_label}"
  appdev_admin_policy_name        = "${var.service_label}${local.appdev_label}${local.admin_label}${local.policy_label}"
  appdev_admin_root_policy_name   = "${var.service_label}${local.appdev_label}${local.admin_label}${local.root_policy_label}"
  iam_admin_policy_name           = "${var.service_label}${local.iam_label}${local.admin_label}${local.policy_label}"
  iam_admin_root_policy_name      = "${var.service_label}${local.iam_label}${local.admin_label}${local.root_policy_label}"
  cred_admin_policy_name          = "${var.service_label}${local.cred_label}${local.admin_label}${local.policy_label}"
  auditor_policy_name             = "${var.service_label}${local.auditor_label}${local.policy_label}"
  announcement_reader_policy_name = "${var.service_label}${local.announce_label}${local.policy_label}"
  exainfra_admin_policy_name      = "${var.service_label}${local.exadata_label}${local.admin_label}${local.policy_label}"
  cost_admin_root_policy_name  = "${var.service_label}${local.cost_label}${local.admin_label}${local.root_policy_label}"

  services_policy_name   = "${var.service_label}${local.svc_policy_label}"
  cloud_guard_statements = ["Allow service cloudguard to read keys in tenancy",
                            "Allow service cloudguard to read compartments in tenancy",
                            "Allow service cloudguard to read tenancies in tenancy",
                            "Allow service cloudguard to read audit-events in tenancy",
                            "Allow service cloudguard to read compute-management-family in tenancy",
                            "Allow service cloudguard to read instance-family in tenancy",
                            "Allow service cloudguard to read virtual-network-family in tenancy",
                            "Allow service cloudguard to read volume-family in tenancy",
                            "Allow service cloudguard to read database-family in tenancy",
                            "Allow service cloudguard to read object-family in tenancy",
                            "Allow service cloudguard to read load-balancers in tenancy",
                            "Allow service cloudguard to read users in tenancy",
                            "Allow service cloudguard to read groups in tenancy",
                            "Allow service cloudguard to read policies in tenancy",
                            "Allow service cloudguard to read dynamic-groups in tenancy",
                            "Allow service cloudguard to read authentication-policies in tenancy",
                            "Allow service cloudguard to use network-security-groups in tenancy"]
  vss_statements       = ["Allow service vulnerability-scanning-service to manage instances in tenancy",
                          "Allow service vulnerability-scanning-service to read compartments in tenancy",
                          "Allow service vulnerability-scanning-service to read vnics in tenancy",
                          "Allow service vulnerability-scanning-service to read vnic-attachments in tenancy"]
  os_mgmt_statements     = ["Allow service osms to read instances in tenancy"]

  database_kms_statements = ["Allow dynamic-group ${var.service_label}-database-kms-dynamic-group to manage vaults in compartment ${local.security_compartment.name}",
        "Allow dynamic-group ${var.service_label}-database-kms-dynamic-group to manage vaults in compartment ${local.security_compartment.name}"]


  # Tags
  tag_namespace_name = "${var.service_label}-namesp"
  createdby_tag_name = "CreatedBy"
  createdon_tag_name = "CreatedOn"

  ### Network
  anywhere                    = "0.0.0.0/0"
  valid_service_gateway_cidrs = ["all-${local.region_key}-services-in-oracle-services-network", "oci-${local.region_key}-objectstorage"]

  # Subnet names
  # Subnet Names used can be changed first subnet will be Public if var.no_internet_access is false
  spoke_subnet_names = ["web", "app", "db"]
  # Subnet Names used can be changed first subnet will be Public if var.no_internet_access is false
  dmz_subnet_names = ["outdoor", "indoor", "mgmt", "ha", "diag"]
  # Mgmt subnet is public by default.
  is_mgmt_subnet_public = true

  dmz_vcn_name = var.dmz_vcn_cidr != null ? {
    name = "${var.service_label}-dmz-vcn"
    cidr = var.dmz_vcn_cidr
  } : {}

  ### Object Storage
  oss_key_name = "${var.service_label}-oss-key"
  bucket_name  = "${var.service_label}-bucket"
  vault_name   = "${var.service_label}-vault"
  vault_type   = "DEFAULT"

  ### Service Connector Hub
  sch_audit_display_name        = "${var.service_label}-audit-sch"
  sch_audit_bucket_name         = "${var.service_label}-audit-sch-bucket"
  sch_audit_target_rollover_MBs = 100
  sch_audit_target_rollover_MSs = 420000

  sch_vcnFlowLogs_display_name        = "${var.service_label}-vcn-flow-logs-sch"
  sch_vcnFlowLogs_bucket_name         = "${var.service_label}-vcn-flow-logs-sch-bucket"
  sch_vcnFlowLogs_target_rollover_MBs = 100
  sch_vcnFlowLogs_target_rollover_MSs = 420000

  sch_audit_policy_name       = "${var.service_label}-audit-sch-policy"
  sch_vcnFlowLogs_policy_name = "${var.service_label}-vcn-flow-logs-sch-policy"

  cg_target_name = "${var.service_label}-cloud-guard-root-target"

  ### Scanning
  scan_default_recipe_name = "${var.service_label}-default-scan-recipe"
  security_cmp_target_name = "${local.security_compartment.key}-scan-target"
  network_cmp_target_name  = "${local.network_compartment.key}-scan-target"
  appdev_cmp_target_name   = "${local.appdev_compartment.key}-scan-target"
  database_cmp_target_name = "${local.database_compartment.key}-scan-target"

  # Delay in seconds for slowing down resource creation
  delay_in_secs = 70

  # Outputs display
  display_outputs = true

  bastion_name = "${var.service_label}-bastion"
  bastion_max_session_ttl_in_seconds = 3 * 60 * 60 // 3 hrs.
}
