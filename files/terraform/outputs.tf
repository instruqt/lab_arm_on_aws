output "instance_public_ip" {
  value = aws_instance.instance.public_ip
}

output "ssh_private_key" {
  value = tls_private_key.rsa-4096.private_key_pem
}
