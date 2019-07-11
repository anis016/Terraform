# 1) Define a provider
provider "aws" {
  region = "${var.region}"
}

# 2) Implement backend configuration
terraform {
  backend "s3" {}
}

# 3) Create VPC
resource "aws_vpc" "production-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Production-VPC"
  }
}

# 4.1) Create Subnet 1
resource "aws_subnet" "public-subnet-1" {
  cidr_block        = "${var.public_subnet_1_cidr}"
  vpc_id            = "${aws_vpc.production-vpc.id}"
  availability_zone = "eu-central-1a"

  tags {
    Name = "Public-Subnet-1"
  }
}

# 4.2) Create Subnet 2
resource "aws_subnet" "public-subnet-2" {
  cidr_block        = "${var.public_subnet_2_cidr}"
  vpc_id            = "${aws_vpc.production-vpc.id}"
  availability_zone = "eu-central-1b"

  tags {
    Name = "Public-Subnet-2"
  }
}

# 4.3) Create Subnet 3
resource "aws_subnet" "public-subnet-3" {
  cidr_block        = "${var.public_subnet_3_cidr}"
  vpc_id            = "${aws_vpc.production-vpc.id}"
  availability_zone = "eu-central-1c"

  tags {
    Name = "Public-Subnet-3"
  }
}
