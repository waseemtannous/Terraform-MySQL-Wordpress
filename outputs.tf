output "ec2_wp_public_ip" {
  value = aws_instance.wp_instance.public_ip
}

output "ec2_mysql_private_ip" {
  value = aws_instance.mysql_instance.private_ip
}
