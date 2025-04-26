# Terraform_Foreman_VM_Creation
This is to build VMs in foreman using terraform automation

Here, i am using terrform provided foreman provider terraform-coop/foreman/0.7.0

# Pre-requisite for setting up terraform provider.
1. vms metadata information in csv format. Check the vms.csv file format and content.
2. Credentials of foreman UI
3. connectivity to internet

# Configure terraform to use foreman provider terraform-coop/foreman/0.7.0
1. Create main.tf file and update required changes.
2. Run terraform init to initialise and download the foreman provide from terraform. It is one time task for foreman provider initialization.
   $ terraform init               
3. Validate the main.tf contents for any erros.
   $ terraform validate
4. If all looks good proceed with terraform planning and apply.
   $ terraform plan          ---->>> Its to show what all metadata stuff being applied on that vms.
   $ terraform apply
