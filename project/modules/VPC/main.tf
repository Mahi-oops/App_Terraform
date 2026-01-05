resource "aws_vpc" "vpc" {
    cidr_block = var.VPC_CIDR
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = "${var.DEVOPS_PROJ}_vpc_settings"
    }
}

resource "aws_internet_gateway" "inter_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "${var.DEVOPS_PROJ}_igw_settings"
    }

}

data "aws_availability_zones" "availability_zones" {}
  
resource "aws_subnet" "public_sub1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUBLIC_CIDR_SUB1
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]

  tags = {
    Name                   = "${var.DEVOPS_PROJ}public-sub1"
    "kubernetes.io/cluster/${var.DEVOPS_PROJ}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "public_sub2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.PUBLIC_CIDR_SUB2
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
   
  tags = {
    Name = "${var.DEVOPS_PROJ}public-sub2"
    "kubernetes.io/cluster/${var.DEVOPS_PROJ}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inter_gateway.id
  } 

  tags = {
    Name = "${var.DEVOPS_PROJ}-pub_rt"
  }
}

resource "aws_route_table_association" "public_rt_a" {
  subnet_id = aws_subnet.public_sub1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rt_b" {
  subnet_id = aws_subnet.public_sub2.id
  route_table_id = aws_route_table.public_route_table.id 
}

resource "aws_subnet" "pri_sub3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.PRI_CIDR_SUB1
  availability_zone = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "pri_sub3"
    "kubernetes.io/cluster/${var.DEVOPS_PROJ}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "pri_sub4" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.PRI_CIDR_SUB2
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "pri_sub4"
    "kubernetes.io/cluster/${var.DEVOPS_PROJ}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}