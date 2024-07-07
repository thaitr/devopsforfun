locals {
  policy_file = jsondecode(file("${path.module}/whitelist_regions.json"))
}
