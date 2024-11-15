## network.tf
- **VPC**: 
  - Sets up a virtual private cloud for resource isolation.

- **Public Subnets**: 
  - Subnets that are accessible from the internet.
  - Each subnet is located in a different availability zone.

- **Public Route Table**: 
  - Manages routing for public subnets.
  - Associated with the Internet Gateway for external connectivity.

- **Private Subnets**: 
  - Subnets without direct internet access.
  - Each subnet is located in a different availability zone.

- **Private Route Table**: 
  - Manages routing for private subnets.
  - Uses a NAT Gateway for internet access.

- **Elastic IP**: 
  - Public IP assigned for the NAT Gateway.

- **NAT Gateway**: 
  - Facilitates internet connectivity for instances in private subnets.

- **Internet Gateway**: 
  - Provides internet access for public subnets.

- **Routes**: 
  - Defines the paths for internet-bound traffic from public and private subnets.

___

## main.tf

- **AWS AMI Data Source**:
  - Retrieves the most recent Amazon Linux 2 AMI.
  - Filters to ensure the AMI is owned by Amazon and matches the "amzn2-ami-hvm-*-x86_64-gp2" naming pattern.

- **AWS Instance**:
  - Provisions an EC2 instance named "jenkins-lenon".
  - Uses the Amazon Linux 2 AMI and is of type `t2.medium`.
  - Associates a public IP address for internet access.
  - Uses a specified key pair for SSH access (`var.keyname`).
  - Configured to use a security group that allows SSH and Jenkins traffic.
  - Placed in a specific public subnet (`aws_subnet.public-subnet-1.id`).
  - Runs a user data script `install_jenkins.sh` to set up Jenkins.

- **AWS Security Group**:
  - Named "allow_ssh_jenkins", designed to allow inbound SSH and Jenkins traffic.
  - Attached to the specified VPC (`aws_vpc.development-vpc.id`).
  - **Ingress Rules**:
    - Allows SSH traffic on port 22 from any IP (`0.0.0.0/0`).
    - Allows Jenkins traffic on port 8080 from any IP (`0.0.0.0/0`).
  - **Egress Rule**:
    - Allows all outbound traffic (all ports and protocols) to any IP (`0.0.0.0/0`).

___

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.66, < 5.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.66.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.elastic-ip-for-nat-gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.jenkins-lenon](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.development-igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat-gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.nat-gw-route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public-internet-igw-route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private-route-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public-route-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private-route-1-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private-route-2-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private-route-3-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-route-1-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-route-2-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-route-3-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.sg_allow_ssh_jenkins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private-subnet-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-subnet-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-subnet-3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-subnet-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-subnet-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-subnet-3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.development-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ami.amazon-linux-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"Development"` | no |
| <a name="input_instance_ami"></a> [instance\_ami](#input\_instance\_ami) | n/a | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_keyname"></a> [keyname](#input\_keyname) | n/a | `any` | n/a | yes |
| <a name="input_private_subnet_1_cidr"></a> [private\_subnet\_1\_cidr](#input\_private\_subnet\_1\_cidr) | Private Subnet 1 cidr block | `any` | n/a | yes |
| <a name="input_private_subnet_2_cidr"></a> [private\_subnet\_2\_cidr](#input\_private\_subnet\_2\_cidr) | Private Subnet 2 cidr block | `any` | n/a | yes |
| <a name="input_private_subnet_3_cidr"></a> [private\_subnet\_3\_cidr](#input\_private\_subnet\_3\_cidr) | Private Subnet 3 cidr block | `any` | n/a | yes |
| <a name="input_public_subnet_1_cidr"></a> [public\_subnet\_1\_cidr](#input\_public\_subnet\_1\_cidr) | Public Subnet 1 cidr block | `any` | n/a | yes |
| <a name="input_public_subnet_2_cidr"></a> [public\_subnet\_2\_cidr](#input\_public\_subnet\_2\_cidr) | Public Subnet 2 cidr block | `any` | n/a | yes |
| <a name="input_public_subnet_3_cidr"></a> [public\_subnet\_3\_cidr](#input\_public\_subnet\_3\_cidr) | Public Subnet 3 cidr block | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC cidr block | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jenkins_ip_address"></a> [jenkins\_ip\_address](#output\_jenkins\_ip\_address) | Jenkins server public dns |
