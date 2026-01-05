output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUBLIC_CIDR_SUB1" {
    value = aws_subnet.public_sub1.id
}

output "PUBLIC_CIDR_SUB2" {
    value = aws_subnet.public_sub2.id
}

output "PRI_CIDR_SUB1" {
    value = aws_subnet.pri_sub3.id
}

output "PRI_CIDR_SUB2" {
    value = aws_subnet.pri_sub4.id
}

output "IGW_ID" {
    value = aws_internet_gateway.inter_gateway.id
}

output "REGION" {
    value = var.REGION
  
}