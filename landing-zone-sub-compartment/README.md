# Landing Zone Sub-Compartment 

This variation of the 'config' Landing Zone template that lets you control 
the naming convention followed when OCI IaaS and IAM resources are created.


### Naming Convention Control Variables

Here is a snippet from the variables.tf file.  
It declares a primary "service label", followed by a set of postfix labels 
that are assembled to form the names of the resources that are created.
Any separators (dash or '-' seen below) should be specified as a leading
separator.  Note that the "service_level" is positioned at 
the beginning of each resource name.


    service_label = "<a_label_to_prefix_resource_names_with>"
    security_label = "-security"
    group_label = "-group"
    dynamic_group_label = "-dynamic-group"
    compartment_label = "-cmp"
    enclosing_compartment_label = "-top"
    network_label = "-network"
    appdev_label = "-appdev"
    database_label = "-database"
    exadata_label = "-exainfra"
    admin_label = "-admin"
    iam_label = "-iam"
    cred_label = "-cred"
    auditor_label = "-auditor"
    announce_label = "-announcement-reader"
    cost_label = "-cost"
    policy_label = "-policy"
    svc_policy_label = "-services-policy"
    root_policy_label = "-root-policy"
    compute_label = "-compute"
    agent_label = "-agent"
  

Feel free to change case or even collapse some labels to get the convention you want:

    #  Naming Convention Control Variables
    service_label = "Product-Group-Alpha"
    security_label = "-Security"
    group_label = "-Group"
    dynamic_group_label = "-Dynamic-Group"
    compartment_label = ""
    enclosing_compartment_label = ""
    network_label = "-Network"
    appdev_label = "-AppDev"
    database_label = "-Database"
    exadata_label = "-Exadata"
    admin_label = "-Admin"
    iam_label = ""
    cred_label = "-Credentials"
    auditor_label = "-Auditor"
    announce_label = "-Announcer"
    cost_label = "-Cost"
    policy_label = "-Policy"
    svc_policy_label = "-Services-Policy"
    root_policy_label = "-Root-Policy"
    compute_label = "-Compute"
    agent_label = "-Agent"
