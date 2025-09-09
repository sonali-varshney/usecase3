resource "aws_instance" "web_instance" {
  count = length(var.pub_cidr_block)
  ami = var.ami #"ami-00ca32bbc84273381" # Example AMI for Amazon Linux 2023 (Free Tier eligible)
  instance_type = var.instance_type #"t3.micro"
  subnet_id = var.subnet_pub_id[count.index] # element(aws_subnet.pubsubnet[*].id, count.index)
  vpc_security_group_ids = var.ec2_sec_gp #[aws_security_group.web_sg.id]

  connection {  #NOTE
    type        = "ssh"
    host        = aws_instance.web_instance[count.index].public_ip
    user        = "ec2-user"
    private_key = file("k8s.pem") # Adjust path to your private key
  }
 
  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y docker",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo usermod -aG docker ec2-user",
      "sg docker -c",
      "sudo mkdir -p /var/lib/openproject/{pgdata,assets}",
      "sudo docker run -d --name openproject -p 8080:80 -e OPENPROJECT_HOST_NAME=${self.public_ip}:8080 -e OPENPROJECT_SECRET_KEY_BASE=$(openssl rand -hex 32) -e OPENPROJECT_HTTPS=false -v /var/lib/openproject/pgdata:/var/openproject/pgdata -v /var/lib/openproject/assets:/var/openproject/assets openproject/openproject:16"
    ]
  }


  tags = {
    Name = "nginx-instance-${count.index}"
  }
}



