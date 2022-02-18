

resource "aws_security_group" "my-sg" {
  name        = "test-sg"
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id = "vpc-05c3c5a7303ff3e4f"

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP through ELB Security Group"
  }
}

resource "aws_key_pair" "testkey" {
  key_name   = "firstkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1qhAm8YUv4H6ixq6mfrx1SwVbZI40W6r42oWP9c9l7vJ3+Z4bFUcqj2SAE0DstCaxe4+2eJkSMtup+SIIzYq696VsZUs3bGcla4Nt0+zCWHB2j0wBcL9NncJLjbkzrUwCSQccz6wtnbD/GJfWIDzIVkmij10Kapqcz7Tst9gcGOqnZjDjr0gIuQNn43cLgaIdSNZjo5f89FMV/+wqrfCF8JJOny+5bELHs7BheKBpSZ5yvqaMCTl3OZctlSrxgz6Wojh0wwQ7Id4E0DiZnjSkAlwZN9DeYMpd6DZFfhMgQzugRDUVxqJowNbN4Z63XvKTGjibgKuH5gmSmFFzdkfz rsa-key-20220209"
}

resource "aws_eip" "test" {
  vpc = true
}