resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "sshKey"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key_pem" {
  filename = "${path.module}/sshKey.pem"
  content  = tls_private_key.pk.private_key_pem
}
