resource "aws_instance" "grafana_stack" {
  ami           = data.aws_ami.ubuntu.id
  instance_type =  "t3.medium"
  vpc_security_group_ids      = [aws_security_group.grafana_stack.id]
  associate_public_ip_address = true
  key_name = "vockey"
  user_data = file("init_script.sh")
  iam_instance_profile = "LabInstanceProfile"
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
  tags = {
    Name = "grafana_stack"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] /* Ubuntu Canonical owner*/

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "grafana_stack_sg" {
  name        = "grafana_stack_sg"
  description = "PokeApp security group"
  ingress {
    description      = "HTTP from Anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "TLS from Anywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  } 
}

