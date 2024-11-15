output "jenkins_ip_address" {
  description = "Jenkins server public dns"
  value       = aws_instance.jenkins-lenon.public_dns
}

# Output the ID of the created VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.development-vpc.id
}

# Output the IDs of the public subnets
output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id,
    aws_subnet.public-subnet-3.id
  ]
}

# Output the IDs of the private subnets
output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value = [
    aws_subnet.private-subnet-1.id,
    aws_subnet.private-subnet-2.id,
    aws_subnet.private-subnet-3.id
  ]
}

# Output the ID of the Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.development-igw.id
}

# Output the public IP address of the Jenkins instance - 
# refer to the EIP's address directly and not use public_ip as this field will change after the EIP is attached.
output "jenkins_instance_public_ip" {
  description = "The public IP address of the Jenkins EC2 instance"
  value       = aws_instance.jenkins-lenon.public_ip
}

# Output the ID of the Jenkins security group
output "jenkins_security_group_id" {
  description = "The ID of the security group used by the Jenkins instance"
  value       = aws_security_group.sg_allow_ssh_jenkins.id
}

# Output the NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat-gw.id
}

# Output the Elastic IP of the NAT Gateway
output "nat_gateway_eip" {
  description = "The Elastic IP address allocated for the NAT Gateway"
  value       = aws_eip.elastic-ip-for-nat-gw.public_ip
}

# Output the Amazon Linux 2 AMI ID
output "amazon_linux_2_ami_id" {
  description = "The ID of the Amazon Linux 2 AMI"
  value       = data.aws_ami.amazon-linux-2023.id
}


output "pblickey_id" {
  description = "Id of the public key"
  value       = data.aws_key_pair.demo.id
}