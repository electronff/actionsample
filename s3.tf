resource "aws_instance" "webserver2" {
  ami           = "ami-00dfe2c7ce89a450b"
  instance_type = "t2.micro"
  tags = {
    Name        = "web"
    Description = "An Nginx WebServer on Ubuntu"
  }
}
terraform {
 backend "s3" {
 bucket = "state2"
 key    = "Terraform\newec2\terraform.tfstate"
 region = "us-east-2"
 dynamodb_table = "state2db"
 }
}
resource "aws_security_group" "ssh-access2" {
  name        = "ssh-access2"
  description = "AllowSSH access from the Internet"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "publicip" {
  value = aws_instance.webserver2.public_ip
}
