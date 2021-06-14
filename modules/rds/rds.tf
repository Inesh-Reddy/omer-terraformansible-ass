resource "aws_db_subnet_group" "db_subnet" {
 
  name  = "main"
  subnet_ids ="${var.private_ids}"
  tags = {
    Name = "My DB subnet group"

  }
}

resource "aws_db_instance" "my_db" {

  allocated_storage    =  20
  engine               = "postgres"
  engine_version       = "12.5"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  db_subnet_group_name = "${aws_db_subnet_group.db_subnet.name}"
  vpc_security_group_ids    = ["${var.db_groupid}"]
  skip_final_snapshot = true
  #parameter_group_name = "default.mysql5.7"
   depends_on = [
     aws_db_subnet_group.db_subnet,
   ]
}