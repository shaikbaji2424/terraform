#Create - VPC
resource "aws_vpc" "tf-ecom" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ecom-vpc"
  }
}


# create pub subnet - AZ -A
resource "aws_subnet" "tf-ecom-pub-sn-A" {
  vpc_id     = aws_vpc.tf-ecom.id
  cidr_block = "192.168.0.0/23"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "ecom-pub-subnet-A"
  }
} 

# create pub subnet - AZ -B
resource "aws_subnet" "tf-ecom-pub-sn-B" {
  vpc_id     = aws_vpc.tf-ecom.id
  cidr_block = "192.168.0.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "ecom-pub-subnet-B"
  }
}

# create pvt subnet - AZ -A
resource "aws_subnet" "tf-ecom-pvt-sn-A" {
  vpc_id     = aws_vpc.tf-ecom.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "ecom-pvt-subnet-A"
  }
}

