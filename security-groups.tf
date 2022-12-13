# Resource-1: Create Security Group for public instances
resource "aws_security_group" "openVpn-SG" {
  name        = "openVpn-vpc-SG"
  description = "VPC public Security Group"
  vpc_id      = aws_vpc.openVpn-vpc.id

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "Allow Port 1194 for vpn"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}