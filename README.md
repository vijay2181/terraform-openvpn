# OpenVpn Server Configuration on AWS


This document provides steps to configure single node [OpenVPN Server](https://en.wikipedia.org/wiki/OpenVPN) cluster in a dedicated AWS VPC and subnet. The OpenVPN server is configured to be readily accessible by the users supplied in the Terraform input file. The same Terraform input file can be used to subsequently update the list of authorised users


image.png



### Please note the following things before you start working on this.

- install Terraform in Local/aws jump Server(take ubuntu or amazon linux 2)

```
sudo apt update -y
sudo apt install awscli -y
sudo apt install wget unzip
pwd
/home/ubuntu
mkdir terraform && cd terraform

cat <<EOF >>/home/ubuntu/terraform/terraform-install.sh
#!/bin/sh
touch terraform-install.sh
TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
sudo wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
sudo unzip terraform_${TER_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
EOF

chmod 755 terraform-install.sh
bash terraform-install.sh
which terraform
terraform --version
 ```

 ```
git clone https://github.com/vijay2181/terraform-openvpn.git
```


## Setup

Before you can use  this repository out of the box, you need

 - an [AWS account](https://portal.aws.amazon.com/gp/aws/developer/registration/index.html)
 - a [Terraform](https://www.terraform.io/intro/getting-started/install.html) CLI
 - a list of users to provision with OpenVPN access

Moreover, you probably had enough of people snooping on you and want some privacy back or just prefer to have a long lived static IP.

In variables.tf file change the variables According to your need
- aws_region
- aws_az
- profile
- tag_name
- cidr_block
- cidr_block_subnet
- instance_type
- instance_root_block_device_volume_size
- ec2_username
- openvpn_install_script_location
- key_name
- key_location
- ovpn_users
- ovpn_config_directory

> Each user provisioned via input `ovpn_users` should preferably be defined as a single word (i.e., no whitespace), _consisting only of ASCII letters and numbers with underscores as delimiters_; in technical terms, each user should adhere to `^[a-zA-Z0-9_]+$`

> make sure you have pem key in the instance, so that with this pem key terraform will ssh into OpenVpn server and copy script

```
terraform init
terraform plan
terraform apply
```

## Testing VPN Connectivity

Once the Terraform module execution has successfully completed, the connection to the OpenVPN can be tested as follows.

> For windows users you can download "OpenVpn GUI for windows"
https://openvpn.net/community-downloads/
you can download the client from above link(ex:- https://swupdate.openvpn.org/community/releases/OpenVPN-2.5.8-I604-amd64.msi)

> valid OpenVPN configuration will downloaded to `generated/ovpn-config/vijay.ovpn `, the connection can be tested by initiating the actual `openvpn`

> import the file to local machine to test on windows machine, open gitbash where your pem file is present

```
scp -i vijay.pem ec2-user@<public_ip>:/home/ec2-user/vijay.ovpn .
```

> import the file by double clicking on it, click on the user and connect
