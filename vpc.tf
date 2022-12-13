# Resources Block
# Resource-1: Create VPC
resource "aws_vpc" "openVpn-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "openVpn-vpc"
  }
}

# Resource-2: Create public Subnet
resource "aws_subnet" "openVpn-public-subnet" {
  vpc_id                  = aws_vpc.openVpn-vpc.id
  cidr_block              = var.cidr_block_subnet
  availability_zone       = var.aws_az
  map_public_ip_on_launch = true
  tags = {
    "Name" = "openVpn-public-subnet"
  }
}


# Resource-3: Internet Gateway
resource "aws_internet_gateway" "openVpnIGW" {
  vpc_id = aws_vpc.openVpn-vpc.id
  tags = {
    "Name" = "openVpnIGW"
  }
}

# Resource-4: Create Route Table 1 for public subnet
resource "aws_route_table" "openVpn-public-RT" {
  vpc_id = aws_vpc.openVpn-vpc.id
  tags = {
    "Name" = "openVpn-public-RT"
  }
}

# Resource-5: Create Route in public Route Table for Internet Access
resource "aws_route" "openVpn-public-route" {
  route_table_id         = aws_route_table.openVpn-public-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.openVpnIGW.id
}


# Resource-6: Associate the public Route Table with the public Subnet
resource "aws_route_table_association" "openVpn-public-route-table-associate" {
  route_table_id = aws_route_table.openVpn-public-RT.id
  subnet_id      = aws_subnet.openVpn-public-subnet.id
}

