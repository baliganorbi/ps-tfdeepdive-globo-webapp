##################################################################################
# RESOURCES
##################################################################################

resource "aws_security_group" "webapp_http_inbound_sg" {
  name        = "${local.name_prefix}-http-inbound"
  description = "Allow HTTP from specific IP range"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ip_range]
  }

  # allow HTTP from this Security Group
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    self            = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = local.vpc_id

  tags = local.common_tags
}

resource "aws_security_group" "webapp_ssh_inbound_sg" {
  name        = "${local.name_prefix}-ssh-inbound"
  description = "Allow SSH from certain ranges"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ip_range]
  }

  vpc_id = local.vpc_id

  tags = local.common_tags
}

resource "aws_security_group" "webapp_outbound_sg" {
  name        = "${local.name_prefix}-webapp-outbound"
  description = "Allow outbound connections"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = local.vpc_id

  tags = local.common_tags
}