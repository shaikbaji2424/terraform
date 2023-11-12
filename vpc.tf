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
  cidr_block = "192.168.0.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "ecom-pub-subnet-A"
  }
} 
