resource "aws_security_group" "web_sg" {
  name        = var.web_sec_gp_name #"web_sec_gp"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.ec2_sec_gp_name #"ec2_secgp"
  }

  # Allow SSH access from anywhere (you can restrict this to your IP)
  ingress {
    from_port = var.ssh_port
    to_port = var.ssh_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # You can change this to your IP for better security
 #security_groups = [aws_security_group.alb_sec_gp.id]  # Only allow traffic from the ALB's security group
  }

    ingress {
    from_port = var.http_port
    to_port = var.http_port
    protocol = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]  # You can change this to your IP for better security
    security_groups = [aws_security_group.alb_sec_gp.id]  # Only allow traffic from the ALB's security group
  }

  # Allow all outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_security_group" "alb_sec_gp" {
  name        = var.alb_sec_gp_name #"db_sec_gp"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "alb_secgp"
  }

  # Allow SSH access from anywhere (you can restrict this to your IP)
  ingress {
    from_port = var.alb_ingress_port #80
    to_port = var.alb_ingress_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Only allow traffic from the EC2's security group
  }

  # Allow all outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



