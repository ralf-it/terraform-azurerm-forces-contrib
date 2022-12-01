
locals {
  tags = {
    creator          = "terraform"
    location         = var.location_info.name
    environment      = var.environment.name
    devops_name      = var.email_receiver_name
    devops_email     = var.email_receiver_address
    devops_phone     = var.email_receiver_phone
    playbook_version = local.playbook_version
    playbook_name    = local.playbook_name
    module_name      = null
    module_version   = null
  }
}

locals {
  playbook_version = var.playbook_version != null ? var.playbook_version : file("${path.root}/VERSION")
  playbook_name    = var.playbook_name != null ? var.playbook_name : basename(path.cwd)
}



