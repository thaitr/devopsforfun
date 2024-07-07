# data "template_file" "policy_json" {
#   template = file("${path.module}/whitelist_regions.json")
#   vars = {
#     policy_name = "My Policy"
#   }
# }
resource "azurerm_policy_definition" "custom_policy" {
  name         = "custom-naming-policy"
  display_name = "Custom Naming Policy"
  description  = "Enforce naming conventions for resources"
  policy_type  = "Custom"
  policy_rule  = jsondecode(local.policy_file)
  mode         = "All"
}
