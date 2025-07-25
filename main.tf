### Below is terraform provider which will be used to build vms

terraform {
  required_providers {
    foreman = {
      source = "terraform-coop/foreman"
      version = "0.7.0"
    }
  }
}

### Below is credentials of foreman UI

provider "foreman" {
  provider_loglevel = "INFO"
  provider_logfile = "terraform-foreman-build.log"

  client_username = "admin"
  client_password = "1234567892"
  client_tls_insecure = "true"

  server_hostname = "fqdn_foreman_server"
  server_protocol = "https"
  location_id = 2
  organization_id = 1
}

### Below is metadata information of vms which needs to create. It looks for file vms.csv in pwd and converts into json format for terraform uses.

locals { 
  csv_data  = file("${path.module}/vms.csv")
  vm_metadata = csvdecode(local.csv_data)
}


### Read the csv file metadata information and pass it in for loop to build vms.
  resource "foreman_host" "vms" {                                                                                                                                                                     
    for_each = { for vm_metadata in local.vm_metadata : vm_metadata.HOSTNAME => vm_metadata }

    name                = each.value.HOSTNAME
    hostgroup_id        = each.value.HOSTGROUP
    managed             = true
    manage_power_operations = false
    set_build_flag      = true

    compute_attributes  =  jsonencode({
      "cores"  : each.value.CPU,
      "memory" : each.value.MEMORY,
      "start" : "1"
    })
}
  
### Add any other required properties like subnet,IP,puppet information etc.

### It will delete resources if it exists or needs update as per resource section above.
  lifecycle {
    prevent_destroy       = false # Allow deletion of the resource
    create_before_destroy = true
  }
}
