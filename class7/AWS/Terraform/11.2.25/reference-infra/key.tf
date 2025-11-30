resource "tls_private_key" "tf_auto_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "tf_auto_key" {
  key_name   = "tf-auto-key"
  public_key = tls_private_key.tf_auto_key.public_key_openssh
}

resource "local_file" "private_key_file" {
  filename        = "./tf_auto_key.pem"
  content         = tls_private_key.tf_auto_key.private_key_pem
  file_permission = "0400"
}