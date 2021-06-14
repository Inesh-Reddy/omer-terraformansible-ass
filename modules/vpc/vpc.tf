resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy =  "default"
    enable_dns_hostnames = true


}
data "aws_availability_zones" "available" {
    state = "available"
    
}

resource "aws_subnet" "private" {

    
    vpc_id = "${var.vpc_id}"
    count = "${length(var.private_cidrs)}"
    availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
    cidr_block = "${element(var.private_cidrs, count.index)}"


}


resource "aws_subnet" "public" {
  vpc_id = "${var.vpc_id}"
  count = "${length(var.public_cidrs)}"
  cidr_block = "${element(var.public_cidrs, count.index)}"
}


#internet gateway for public subnet

resource "aws_internet_gateway" "igw" { 
  vpc_id = "${var.vpc_id}" 
 
} 

 
 
resource "aws_route_table" "public" { 
  vpc_id = "${var.vpc_id}"
  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.igw.id 
  } 
  
} 

 
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id 
} 

#NAT gateway for private subnet
resource "aws_eip" "nat" { 
  vpc      = true 
} 
 
resource "aws_nat_gateway" "ngw" { 
  allocation_id = aws_eip.nat.id  
  subnet_id = element(aws_subnet.public.*.id, 0)  
} 
 
resource "aws_route_table" "private" {  
  vpc_id = "${var.vpc_id}"
  route { 
    cidr_block = "0.0.0.0/0" 
    nat_gateway_id = aws_nat_gateway.ngw.id
  } 

} 
 
resource "aws_route_table_association" "private" {  
  count = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id 
} 

resource "aws_security_group" "allow_ssh" {
  name        = "ssh-sg"
  description = "used in ec2 instance"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "db_connection" {
  name        = "db-sg"
  description = "used in rds instance"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_ssh.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}


# output "vpc_id" {
#     value = "${aws_vpc.main.id}"
# }

# # output for private subnet id
# output "private_ids" {
#     value = "${aws_subnet.private.*.id}"
# }

# #output for public subnet id
# output "public_ids" {
#     value = "${aws_subnet.public.*.id}"
# }