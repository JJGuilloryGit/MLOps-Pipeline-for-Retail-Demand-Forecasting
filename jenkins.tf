resource "aws_instance" "jenkins_server" {
  ami           = "ami-05b10e08d247fb927"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.jenkins_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install openjdk-11-jdk -y
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt update -y
    sudo apt install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo apt install docker.io -y
    sudo usermod -aG docker jenkins
    sudo apt install git -y
    sudo apt install python3-pip -y
    sudo pip3 install awscli boto3
    sudo systemctl restart jenkins
  EOF

  tags = {
    Name = "Jenkins-Server"
  }
}


resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins server"
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Jenkins web interface"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "jenkins_key_pair" {
  key_name   = "jenkins-key-pair"  # Name for your key pair in AWS
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPvdSfMEksMX6G/jDKuy/9TSMFlYrwJK9WS3TXx6ffZm jjgui@DESKTOP-C8IR938"
}


