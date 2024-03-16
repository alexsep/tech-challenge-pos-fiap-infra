resource "aws_vpc" "tc-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
  count = 2   
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.tc-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name ="${var.prefix}-subnet-${count.index}"
  }
}


resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.tc-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "new-rtb" {
 vpc_id = aws_vpc.tc-vpc.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id =  aws_internet_gateway.new-igw.id
 }
 tags = {
    Name = "${var.prefix}-route-table"
 }
}

resource "aws_route_table_association" "subnet_rtb_association" {
 count = 2
 subnet_id      = aws_subnet.subnets.*.id[count.index]
 route_table_id = aws_route_table.new-rtb.id
}
