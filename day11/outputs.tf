
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