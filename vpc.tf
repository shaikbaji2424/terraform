# Create - VPC
resource "aws_vpc" "tf-ecomm" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ecomm-vpc"
  }
}

# Create Pub Subnet - AZ - A
resource "aws_subnet" "tf-ecomm-pub-sn-A" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "192.168.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "ecomm-public-subnet-A"
  }
}

# Create Pub Subnet - AZ - B
resource "aws_subnet" "tf-ecomm-pub-sn-B" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "ecomm-public-subnet-B"
  }
}

# Create Pvt Subnet - AZ - A
resource "aws_subnet" "tf-ecomm-pvt-sn-A" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "ecomm-private-subnet-A"
  }
}

# Create Pvt Subnet - AZ - B
resource "aws_subnet" "tf-ecomm-pvt-sn-B" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "ecomm-private-subnet-B"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "tf-ecomm-igw" {
  vpc_id = aws_vpc.tf-ecomm.id

  tags = {
    Name = "ecomm-internet-internet"
  }
}

# Create Public Route Table
resource "aws_route_table" "tf-ecomm-pub-rt" {
  vpc_id = aws_vpc.tf-ecomm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-ecomm-igw.id
  }

  tags = {
    Name = "ecomm-public-route-table"
  }
}

# Create Private Route Table
resource "aws_route_table" "tf-ecomm-pvt-rt" {
  vpc_id = aws_vpc.tf-ecomm.id

  tags = {
    Name = "ecomm-private-route-table"
  }
}

# Create Public Associations 
resource "aws_route_table_association" "tf-ecomm-pub-asc-A" {
  subnet_id      = aws_subnet.tf-ecomm-pub-sn-A.id
  route_table_id = aws_route_table.tf-ecomm-pub-rt.id
}

resource "aws_route_table_association" "tf-ecomm-pub-asc-B" {
  subnet_id      = aws_subnet.tf-ecomm-pub-sn-B.id
  route_table_id = aws_route_table.tf-ecomm-pub-rt.id
}

# Create Private Associations
resource "aws_route_table_association" "tf-ecomm-pvt-asc-A" {
  subnet_id      = aws_subnet.tf-ecomm-pvt-sn-A.id
  route_table_id = aws_route_table.tf-ecomm-pvt-rt.id
}

resource "aws_route_table_association" "tf-ecomm-pvt-asc-B" {
  subnet_id      = aws_subnet.tf-ecomm-pvt-sn-B.id
  route_table_id = aws_route_table.tf-ecomm-pvt-rt.id
}

# Create Public NACL
resource "aws_network_acl" "tf-ecomm-pub-nacl" {
  vpc_id = aws_vpc.tf-ecomm.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "ecomm-public-nacl"
  }
}

# Create Private NACL
resource "aws_network_acl" "tf-ecomm-pvt-nacl" {
  vpc_id = aws_vpc.tf-ecomm.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "ecomm-private-nacl"
  }
}

# Create NACL - Public - Association
resource "aws_network_acl_association" "tf-ecomm-pub-nacl-asc-A" {
  network_acl_id = aws_network_acl.tf-ecomm-pub-nacl.id
  subnet_id      = aws_subnet.tf-ecomm-pub-sn-A.id
}

resource "aws_network_acl_association" "tf-ecomm-pub-nacl-asc-B" {
  network_acl_id = aws_network_acl.tf-ecomm-pub-nacl.id
  subnet_id      = aws_subnet.tf-ecomm-pub-sn-B.id
}
