

# Create a VPC for the development environment
resource "aws_vpc" "development-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment}-VPC"
  }
}


# Create public subnets in each availability zone
resource "aws_subnet" "public-subnet-1" {
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.environment}-Public-Subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.environment}-Public-Subnet-2"
  }
}


resource "aws_subnet" "public-subnet-3" {
  cidr_block        = var.public_subnet_3_cidr
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "${var.region}c"
  tags = {
    Name = "${var.environment}-Public-Subnet-3"
  }
}


# Create a public route table for the public subnets
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "${var.environment}-Public-RouteTable"
  }
}


# Associate the public route table with each public subnet
resource "aws_route_table_association" "public-route-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}


resource "aws_route_table_association" "public-route-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}


resource "aws_route_table_association" "public-route-3-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-3.id
}


# Create private subnets in each availability zone
resource "aws_subnet" "private-subnet-1" {
  cidr_block        = var.private_subnet_1_cidr
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.environment}-Private-Subnet-1"
  }
}


resource "aws_subnet" "private-subnet-2" {
  cidr_block        = var.private_subnet_2_cidr
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.environment}-Private-Subnet-2"
  }
}


resource "aws_subnet" "private-subnet-3" {
  cidr_block        = var.private_subnet_3_cidr
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "${var.region}c"
  tags = {
    Name = "${var.environment}-Private-Subnet-3"
  }
}


# Create a private route table for the private subnets
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "${var.environment}-Private-RouteTable"
  }
}


# Associate the private route table with each private subnet
resource "aws_route_table_association" "private-route-1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-1.id
}


resource "aws_route_table_association" "private-route-2-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-2.id
}


resource "aws_route_table_association" "private-route-3-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-3.id
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "elastic-ip-for-nat-gw" {
  domain                    = "vpc"
  associate_with_private_ip = "10.0.0.5"
  tags = {
    Name = "${var.environment}-EIP"
  }
}


# Create a NAT Gateway in the first public subnet
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  subnet_id     = aws_subnet.public-subnet-1.id
  tags = {
    Name = "${var.environment}-NATGW"
  }
  depends_on = [aws_eip.elastic-ip-for-nat-gw]
}


# Route traffic from the private subnets to the internet via the NAT Gateway
resource "aws_route" "nat-gw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}


# Create an Internet Gateway for public internet access
resource "aws_internet_gateway" "development-igw" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "${var.environment}-IGW"
  }
}


# Route internet-bound traffic from the public subnets through the Internet Gateway
resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.development-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
