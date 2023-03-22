data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["909263615116"] 
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.jenkins-sg.name]
  key_name        = "jenkins-key"
  subnet_id = var.public1_subnet_id
  associate_public_ip_address = true
  tags = {
    "Name" = "Jenkins"
  }
}

resource "aws_network_interface_sg_attachment" "jenkins_sg_attachment" {
  security_group_id    = aws_security_group.jenkins-sg.id
  network_interface_id = aws_instance.jenkins.primary_network_interface_id
}