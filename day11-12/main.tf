locals {
  formatted_project_name = lower(replace(var.project_name)," ","_")
  new_tag = merge(var.default_tags, var.environment_tags)
  formatted_bucket_name = replace(replace(substr(lower(var.bucket_name),0,63)," ","_"),"!","")
  allowed_ports_list = split(",", var.allowed_ports)
  sg_rules = [for port in local.allowed_ports_list:{
    name        =  "allow_port_${port}"
    from_port   = tonumber(port)
    to_port     = tonumber(port)
    description = "Allow inbound traffic on port ${port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  instance_sizes = lookup(var.instance_sizes, var.environment, "t3.medium")


  all_locations=concat(var.user_locations, var.default_locations)

  unique_locations = toset(local.all_locations)

  positive_cost = [for cost in var.monthly_costs : abs(cost) ]
  maximum_cost = max(local.positive_cost...)
  minimum_cost = min(local.positive_cost...)
  total_cost   = sum(local.positive_cost)
  average_cost = local.total_cost / length(local.positive_cost)


  current_timestamp = timestamp()
  format1 = formatdate("YYYY-MM-DD", local.current_timestamp)
  format2 = formatdate("YYYYMMDD_HHMMSS", local.current_timestamp)

  config_file_exists = fileexists("./config.json")
  config_data=local.config_file_exists? jsondecode(file("./config.json")) : {}
}

resource "aws_s3_bucket" "firsts3" {

  bucket = local.formatted_bucket_name

  tags = local.new_tag
  
}



