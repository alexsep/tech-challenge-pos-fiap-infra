output "vpc_id" {
  value = aws_vpc.tc-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.subnets[*].id
}