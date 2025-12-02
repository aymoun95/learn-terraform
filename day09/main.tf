resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.allowed_vm_types[1]
  region        = var.region

  tags = var.tags

  lifecycle {
    create_before_destroy = false
    # prevent_destroy       = true
  }
}


# Launch Template for Auto Scaling Group
resource "aws_launch_template" "app_server" {
  name_prefix   = "app-server-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "App Server from ASG"
      Demo = "ignore_changes"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app_servers" {
  name               = "app-servers-asg"
  min_size           = 1
  max_size           = 5
  desired_capacity   = 2
  health_check_type  = "EC2"
  availability_zones = data.aws_availability_zones.available.names

  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "App Server ASG"
    propagate_at_launch = true
  }

  tag {
    key                 = "Demo"
    value               = "ignore_changes"
    propagate_at_launch = false
  }

  # Lifecycle Rule: Ignore changes to desired_capacity
  # This is useful when auto-scaling policies or external systems modify capacity
  # Terraform won't try to revert capacity changes made outside of Terraform
  lifecycle {
    ignore_changes = [
      desired_capacity,
      # Also ignore load_balancers if added later by other processes
    ]
  }
}
