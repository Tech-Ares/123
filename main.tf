# Configure the AWS provider
provider "aws" {
  region = "us-west-2"  # 你可以根据需求更改 AWS 区域
}

# Create a security group to allow inbound SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # 更换为你所在区域的有效 AMI ID
  instance_type = "t2.micro"  # 选择实例类型
  key_name      = "your-key-name"  # 请确保你有一个 AWS EC2 密钥对

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "MyEC2Instance"
  }
}
