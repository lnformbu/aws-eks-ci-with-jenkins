# Retrieves the latest Amazon Linux 2 AMI provided by Amazon
data "aws_ami" "amazon-linux-2023" {
  most_recent = true
  owners      = ["amazon"]

  # Filter to match AMI names for Amazon Linux 2
  filter {
    name = "name"
    values = [
      "al2023-ami-2023.*-x86_64",
    ]
  }

  # Filter to ensure the owner is Amazon
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}


# This data block fetches information about an existing key pair in the AWS account.
data "aws_key_pair" "demo" {
  key_name           = "demo" # The key pair name must match an existing key pair in your AWS account. This allows secure access to the EC2 instance.
  include_public_key = true
}


# Creates an EC2 instance to run Jenkins
resource "aws_instance" "jenkins-lenon" {
  ami           = data.aws_ami.amazon-linux-2023.id # Uses the AMI fetched above
  instance_type = "t2.medium"                       # Specifies the instance type as t2.medium
  key_name      = data.aws_key_pair.demo.key_name   #var.keyname                     # Uses a provided key pair for SSH access

  # Attaches the security group that allows SSH and Jenkins access
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]

  subnet_id = aws_subnet.public-subnet-1.id # Places the instance in a public subnet
  user_data = file("install_jenkins.sh")    # Runs a script to install Jenkins on launch

  associate_public_ip_address = true # Assigns a public IP address for external access
  tags = {
    Name    = "jenkins-lenon" # Tags the instance with a name
    purpose = "${var.environment}-test"
  }
}

# Defines a security group to control access to the Jenkins server
resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"                     # Security group name
  description = "Allow SSH and Jenkins inbound traffic" # Description of the security group
  vpc_id      = aws_vpc.development-vpc.id              # Associates with the specified VPC

  # Allows SSH access on port 22 from any IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows Jenkins access on port 8080 from any IP address
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows all outbound traffic to any IP address
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    purpose = "${var.environment}-sg"
  }
}
