
// vpc 
resource "aws_vpc" "main"{
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "myVpc"
    }
}
// public subnet
resource "aws_subnet" "public_subnet"{
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.public_subnet_cidrs,count.index)
     availability_zone = element(var.azs,count.index)

    tags={
        Name = "Public subnet ${count.index + 1}"
    }
} 
// privete subnet
resource "aws_subnet" "private_subnet"{
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.private_subnet_cidrs,count.index)
    availability_zone = element(var.azs,count.index)

    tags={
        Name = "Private subnet ${count.index + 1}"
    }
} 
 // internet gateway creation associate with th vpn
resource "aws_internet_gateway" "gateway"{
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "Internet gateway"
    }
}
// route table creation
resource "aws_route_table" "second_rt"{
    vpc_id = aws_vpc.main.id
   route {
    cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.gateway.id
   }
   tags = {
    Name = "Second Route Table"
   }
}
// association of subnet to a route table
resource "aws_route_table_association" "public_subnet_asso"{
    count = length(var.public_subnet_cidrs)
    subnet_id = element(aws_subnet.public_subnet[*].id, count.index)
    route_table_id = aws_route_table.second_rt.id
}