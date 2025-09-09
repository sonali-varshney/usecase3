resource "aws_instance" "web_instance" {
  count = length(var.pub_cidr_block)
  ami = var.ami #"ami-00ca32bbc84273381" # Example AMI for Amazon Linux 2023 (Free Tier eligible)
  instance_type = var.instance_type #"t3.micro"
  subnet_id = var.subnet_pub_id[count.index] # element(aws_subnet.pubsubnet[*].id, count.index)
  vpc_security_group_ids = var.ec2_sec_gp #[aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo dnf update -y
    sudo dnf install -y docker
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    newgrp docker
    docker run -d -p 80:80 --name openproject openproject/community:13

  EOF

  tags = {
    Name = "nginx-instance-${count.index}"
  }
}



