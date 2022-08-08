# security group
resource "aws_security_group" "wp_sg" {
  name        = "allow_web"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Web"
    from_port   = 8080
    to_port     = 8080
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
    Name = "allow_web"
  }
}


# network interface
resource "aws_network_interface" "wp_ni" {
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.wp_sg.id]

  tags = {
    Name = "primary_network_interface"
  }
}

# ec2 instance
resource "aws_instance" "wp_instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.key_name

  network_interface {
    network_interface_id = aws_network_interface.wp_ni.id
    device_index         = 0
  }

  user_data  = file("userData/wordpress.sh")
  depends_on = [aws_internet_gateway.gw_main]
}
