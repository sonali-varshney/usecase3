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
    docker run -it -p 8080:80 -e OPENPROJECT_SECRET_KEY_BASE=openProject@123 \
    -e OPENPROJECT_HOST__NAME=${self.public_ip}:8080 \
    -e OPENPROJECT_HTTPS=false openproject/openproject:16
    
  EOF

  tags = {
    Name = "nginx-instance-${count.index}"
  }
}



