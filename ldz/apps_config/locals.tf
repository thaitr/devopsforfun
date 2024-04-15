locals {
  all_tags = {
    location  = "eastus",
    terraform = true
  }
  app_config_label = "music_label"

  config_mapping = {
    key1 = {
      name  = "payment:key1"
      value = "value1"
    }
    key2 = {
      name  = "payment:key2"
      value = "value2"
    }
    key3 = {
      name  = "payment:key3"
      value = "value3"
    }
    key4 = {
      name  = "payment:key4"
      value = "value4"
    }

  }
  environment = {
    dev = {
      location = "eastus"
    }
    prod = {
      location = "eastu2"
    }
  }
}
