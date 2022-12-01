# [tflint/docs/user-guide/config.md at master · terraform-linters/tflint](https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md)

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "azurerm" {
  enabled = true
  version = "0.25.1"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# [tflint/docs/user-guide/calling-modules.md at master · terraform-linters/tflint](https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/calling-modules.md)
# By default, TFLint only calls local modules whose the source is a relative path like ./*. If you want to call remote modules (registry, git, etc.), you must run terraform init (or terraform get) before invoking TFLint so that modules are loaded into the .terraform directory. After that, invoke TFLint with --call-module-type=all.
# Accepts: (all, local (default), none)
#
config {
  call_module_type = "none"
  varfile          = []
}

# rule "terraform_unused_declarations" {
#   enabled = true
# }
