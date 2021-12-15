# Partner Sub-Compartment Landing Zone Configuration

Manage LZ resources within a sub-compartment.

## Naming Label Components

service-prefix-label

        "Xactware-Prod"
        "Xactware-Non-Prod"
        "EnterpriseApps-Fin-Prod"
        "EnterpriseApps-Fin-Non-Prod"

service-suffix-label

        "-Network"
        "-Security"
        "-AppDev"
        "-Database"

group-suffix-label

        "-Group"

## Enclosing Compartment 

        existing_enclosing_compartment_ocid = "<ocid>"

Create these existing compartments:

            "Xactware-Dev"
            "Xactware-Prod"
            "EnterpriseApps-Fin-Dev"
            "EnterpriseApps-Fin-Prod"

## Okta Group Mapping

        use_existing_groups                     = true

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