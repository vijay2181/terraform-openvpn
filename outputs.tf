output "public_ip_addr" {
  value = aws_instance.openvpn.*.public_ip
  description = "The public IP address of the main server instance"
}

output "private_ip_addr" {
  value = aws_instance.openvpn.*.private_ip
  description = "The public IP address of the main server instance"
}


data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

output "profile" {
  value = var.profile
}

