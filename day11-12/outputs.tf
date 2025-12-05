
output "formatted_project_name" {
    value = local.formatted_project_name
}

output "port_list" {
    value = local.allowed_ports_list
}


output "sg_rules" {
    value = local.sg_rules
}

output "instance_sizes" {
    value = local.instance_sizes
}


output "creadentials" {
    value = var.credentials
  sensitive = true
}


output "all_locations" {
    value = local.all_locations
  
}

output "positive_cost" {
    value = local.positive_cost
  
}

output "maximum_cost" {
    value = local.maximum_cost
}

output "minimum_cost" {
   value = local.minimum_cost
}


output "config" {
    value = local.config_data
  
}