# Input Variables - Values provided to Terraform configuration
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "my-terraform-bucket"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}


variable "monitoring_enabled" {
  description = "Enable CloudWatch monitoring"
  type        = bool
  default     = true
}

variable "associate_public_ip_address" {
  description = "Associate public IP address"
  type        = bool
  default     = true
}


variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = list(string)
  default     = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
}


variable "allowed_vm_types" {
  description = "Allowed VM types"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t3.micro"]
}


variable "allowed_regions" {
  description = "Allowed regions"
  type        = set(string)
  default     = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
}


variable "tags" {
  description = "Tags for EC2 instances"
  type        = map(string)
  default = {
    Environment = "dev"
    Name        = "dev-Instance"
    created_by  = "terraform"
  }
}

variable "ingress_values" {
  type    = tuple([number, string, number])
  default = [443, "tcp", 443]

}


variable "config" {
  type = object({
    region         = string
    monitoring     = bool
    instance_count = number
  })

  default = {
    region         = "us-east-1"
    monitoring     = true
    instance_count = 1
  }
}


variable "bucket_names" {
  description = "List of S3 bucket names to create"
  type        = list(string)
  default     = ["bucket1", "bucket2", "bucket3"]

}


variable "bucket_names_set" {
  description = "List of S3 bucket names to create"
  type        = set(string)
  default     = ["bucket1", "bucket2", "bucket3"]

}


variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    }
  ]
}





variable "bucket_name" {

  default = "my-unique-bucket-name-12345"
  
}