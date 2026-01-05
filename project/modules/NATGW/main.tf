resource "aws_eip" "EIP_NAT_GTW1" {
    domain = "vpc"
 
    tags = {
      Name = "EIP1_NAT"
    }

}

resource "aws_eip" "EIP_NAT_GTW2" {
  domain = "vpc"

    tags = {
      Name = "EIP2_NAT"
    }
   
}

resource "aws_nat_gateway" "NAT_GTW1" {
  allocation_id = aws_eip.EIP_NAT_GTW1.id
  subnet_id = var.public_ID1

  tags = {
    Name = "nat_gtw1"
  }
 depends_on = [var.IGW_ID] 
}


resource "aws_nat_gateway" "NAT_GTW2" {
  allocation_id = aws_eip.EIP_NAT_GTW2.id
  subnet_id = var.public_ID2

  tags = {
    Name = "nat_gtw2"
  }
  depends_on = [ var.IGW_ID ]
}

resource "aws_route_table" "private_rt1" {
  vpc_id = var.VPC_ID

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GTW1.id
  }

  tags = {
    Name = "private_rt1"
  }
}

resource "aws_route_table_association" "private_rt1_a" {
  subnet_id = var.private_ID1
  route_table_id = aws_route_table.private_rt1.id
  
}

resource "aws_route_table" "private_rt2" {
  vpc_id = var.VPC_ID

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GTW2.id
  }

  tags = {
    Name = "private_rt2"
  }
}

resource "aws_route_table_association" "private_rt2_a" {
  subnet_id = var.private_ID2
  route_table_id = aws_route_table.private_rt2.id
  
}