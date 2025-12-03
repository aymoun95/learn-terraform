resource "aws_instance" "example" {
  ami           = "ami-0ff8a91507f77f867"
  count         = var.instance_count
  instance_type = var.environment == "dev" ? "t2.micro" : "t3.micro"

  tags = var.tags
}


resource "aws_security_group" "example" {
  name   = "sg"
  vpc_id = aws_vpc.example.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
  egress = []
}

locals {
  all_instance_ids = aws_instance.example[*].id
}


output "instances" {
  value = locals.all_instance_ids

}
