data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

locals {
  public_subnet_ids = sort(data.aws_subnets.public.ids)
}

resource "aws_security_group" "nginx_sg" {
  name_prefix = "terraform-nginx-sg-"
  description = "Allow selected ports from anywhere"
  vpc_id      = var.vpc_id

  tags = {
    Name = "terraform-nginx-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "open_ports" {
  for_each = toset([for port in var.list_of_open_ports : tostring(port)])

  security_group_id = aws_security_group.nginx_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = tonumber(each.value)
  to_port     = tonumber(each.value)
  ip_protocol = "tcp"

  description = "Allow TCP port ${each.value} from anywhere"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.nginx_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow all outbound traffic"
}

resource "aws_instance" "nginx" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type               = "t3.micro"
  subnet_id                   = local.public_subnet_ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>Nginx works from Terraform module</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = "terraform-nginx-instance"
  }
}