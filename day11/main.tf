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
}

resource "aws_s3_bucket" "firsts3" {

  bucket = local.formatted_bucket_name

  tags = local.new_tag
  
}



