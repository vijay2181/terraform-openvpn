variable "aws_region" {
  description = "The AWS region to use"
  default     = "us-west-2"
}

variable "aws_az" {
  description = "The AWS Availability-zone to use"
  default     = "us-west-2a"
}

variable "profile" {
  description = "The profile to use"
  default     = "test"
}

variable "tag_name" {
  description = "The name to tag AWS resources with"
  default     = "OpenVpnServer"
}

variable "cidr_block" {
  description = "The CIDR block range to use for the OpenVPN VPC"
  default     = "10.0.0.0/16"
}

variable "cidr_block_subnet" {
  description = "The CIDR block range to use for the OpenVPN VPC"
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "The instance type to use"
  default     = "t2.micro"
}

variable "instance_root_block_device_volume_size" {
  description = "The size of the root block device volume of the EC2 instance in GiB"
  default     = 8
}

variable "ec2_username" {
  description = "The user to connect to the EC2 as"
  default     = "ec2-user"
}

variable "openvpn_install_script_location" {
  description = "The location of an OpenVPN installation script compatible with"
  default     = "https://raw.githubusercontent.com/dumrauf/openvpn-install/master/openvpn-install.sh"
}

variable "key_name" {
  description = "ec2 keypair name"
  type        = string
  default     = "ninaquad" #give keypair name which is present in aws
}

variable "key_location" {
  description = "ec2 keypair location on local server"
  type        = string
  default     = "/home/ubuntu/ninaquad.pem" #give keypair name which is present in aws
}

variable "ovpn_users" {
  type        = list(string)
  description = "The list of users to automatically provision with OpenVPN access"
  default     = ["vijay", "ajay", "jay"]
}

variable "ovpn_config_directory" {
  description = "The name of the directory to eventually download the OVPN configuration files to"
  default     = "generated/ovpn-config"
}

