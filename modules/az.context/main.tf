

module "update" {
  source = "../az.context.update"

  playbook_name    = local.playbook_name
  playbook_version = local.playbook_version
  module_name      = null
  module_path      = null

  configs = {
    prefix = var.prefix
    suffix = var.suffix

    customer = var.customer

    myip             = local.myip
    myip_cidr        = local.myip_cidr
    allowed_ips      = local.allowed_ips
    allowed_ip_cidrs = local.allowed_ip_cidrs

    tenant_id            = local.tenant_id
    client_id            = local.client_id
    object_ids           = local.object_ids
    subscription_id      = local.subscription_id
    subscription_id_full = local.subscription_id_full
    timestamp_compact    = local.timestamp_compact

    location_info = var.location_info
    location      = var.location
    environment   = var.environment

    current_datetime    = local.current_datetime
    current_date        = local.current_date
    one_year_later_date = local.one_year_later_date

    email_receiver_name    = var.email_receiver_name
    email_receiver_address = var.email_receiver_address
    email_receiver_phone   = var.email_receiver_phone

    members_rbac = var.members_rbac

    config_dir = var.config_dir
    custom_logs_dir = coalesce(var.custom_logs_dir, "${var.config_dir}/logs")

    tags = local.tags
  }
}


