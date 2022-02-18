resource "aws_vpc" "myvpc" {
    cidr_block = "192.168.0.0/16"

    tags = {
        "Name" = "from-tf"
    }
}


resource "aws_subnet" "subnet1" {
    cidr_block = "192.168.0.0/24"

    vpc_id = "${aws_vpc.myvpc.id}"

    availability_zone = "us-west-2a"

    tags = {
        "Name" = "subnet-1"
    }
  
}

resource "aws_subnet" "subnet2" {
    cidr_block = "192.168.1.0/24"
    availability_zone = "us-west-2b"
    tags = {
        "Name" = "subnet2"
    }
    vpc_id = "${aws_vpc.myvpc.id}"
  
}

resource "aws_subnet" "subnet3" {
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-west-2c"
  tags = {
      "Name" = "subnet3"
  }
  vpc_id = "${aws_vpc.myvpc.id}"
}

resource "aws_db_subnet_group" "dbsubnet" {
  name       = "db subnet group for rds"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]

  tags = {
    Name = "My DB subnet group"
  }
}