provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

resource "aws_security_group" "ssh-sg" {
  name = "the-sg-for-ssh-1"
  ingress {
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
}
resource "aws_security_group" "web-sg" {
  name = "the-sg-for-web-1"
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0df99b3a8349462c6"
  instance_type = "t2.micro"
  key_name = "2021-ec2"
  vpc_security_group_ids = [aws_security_group.web-sg.id, aws_security_group.ssh-sg.id]
  tags = {
    Name = "t2-micro-20211001"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "2021-ec2-1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkFj8ikeUKu/d3bC3nNKCCUqhj+UWRf2chGBrUzu3u/18fEo+7DN9827iE/I/ZnpdNy19SJr0VMfkRTeBgLwrLgYN5NhdSGFoMiAKqvzjxxX0kyrJlLu8nkdjGq4mKRq9Ktfw7j6buWIxkm4SeSC6RsJLXteMvRkpiYV92KXvjg1ZDDUanWLtyKpVK8jfHjOrGaevolE5jB1O/G7AXDuF/poeN1tOfe67hLdHqZVmLO55zRD5ezEwwDO9RlVXyX1kDzCzfcE6owXaasIR3GJq6x8i7ozZk9RymljoytVjzhxjtU5LGjyeMWdlWba1HtkyWM1jzLxTuXJHbcVqBNsBrtXBt18P0s/3kUaD+RVFgXrMFpPGT6Drh157neADzD5I1JvlJo0lUaMJ0E+P3jjuO2xMysBK5EQCPWhW7wHLtDm579Ou7ShFzrQkvbmEh84pNOSPy+6XqFOi4cFW0dMHtlge5YXcqWxpdQQl13DixdGFoteg3h1kRFTw9NoJR9nU= ace@arcmac"
}
