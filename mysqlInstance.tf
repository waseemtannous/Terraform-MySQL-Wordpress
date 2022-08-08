# security group
resource "aws_security_group" "mysql_sg" {
  name        = "allow_mysql"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
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
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_mysql"
  }
}


# network interface
resource "aws_network_interface" "mysql_ni" {
  subnet_id       = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.mysql_sg.id]

  tags = {
    Name = "primary_network_interface"
  }
}

# ec2 instance
resource "aws_instance" "mysql_instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.key_name

  network_interface {
    network_interface_id = aws_network_interface.mysql_ni.id
    device_index         = 0
  }
  user_data  = file("userData/mysql.sh")
  depends_on = [aws_nat_gateway.nat, aws_network_interface.mysql_ni, aws_route_table_association.private_rta]
}
