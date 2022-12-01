# # ! messing up my VSCode terminal
# resource "null_resource" "subnets_validate_address_space" {

#   count = var.nmap_path != null && var.nmap_path != "" ? 1 : 0

#   triggers = {
#     "subnet_cidrs" = join(",", local.cidrs)
#     "vnet_cidr"    = var.virtual_network_address_space
#     "nmap_path"    = var.nmap_path
#     "always"       = timestamp() ## DEBUGGING
#   }

#   provisioner "local-exec" {
#     command = "bash ${path.module}/scripts/validate.sh"
#     environment = {
#       SUBNETS       = join(" ", flatten(concat(local.cidrs)))
#       ADDRESS_SPACE = var.virtual_network_address_space
#     }
#   }
# }
