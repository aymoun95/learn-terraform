variable "project_name" {
  default = "Project ALPHA Resource"
  
}


variable "default_tags" {
  type = map(string)
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}

variable "environment_tags" {
  type = map(string)
  default = {
    environment = "production"
    cost_center = "cc-123"
  }
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name (must be globally unique)"
  default     = "ProjectAlphaStorageBucket with CAPS and spaces!!!"
}

variable "allowed_ports" {
  default = "22,80,443,8080"
  
}

variable "instance_sizes" {
  type = map(string)
  default = {
    dev     = "t2.micro"
    staging = "t3.small"
    prod    = "t3.large"
  }
}

variable "environment" {
  default = "dev"
  
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
  validation {
    condition     = length(var.instance_type) >2 && length(var.instance_type) <20
    error_message = "Instance type must be between 2 and 20 characters long."
  }

  validation {
    condition = can(regex("^t[2-3]\\.",var.instance_type))
    error_message = "Instance type must start with t2 or t3"
  }
}

variable "backup_name" {
  type        = string
  description = "Backup configuration name"
  default     = "daily_backup"

  validation {
    condition     = endswith(var.backup_name, "_backup")
    error_message = "Backup name must end with '_backup'"
  }
}



variable "credentials" {
  default = "xyz1234"
  sensitive = true

  
}



variable "user_locations" {
  type        = list(string)
  description = "User-specified AWS regions"
  default     = ["us-east-1", "us-west-2", "us-east-1"] # Contains duplicate
}

variable "default_locations" {
  type        = list(string)
  description = "Default AWS regions"
  default     = ["us-west-1"]
}



variable "monthly_costs" {
  type        = list(number)
  description = "Monthly infrastructure costs (can include negative values for credits)"
  default     = [-50, 100, 75, 200]
}