output "ec2_sec_gp"{
value = aws_security_group.web_sg.id
}

output "alb_sec_gp"{
value = aws_security_group.alb_sec_gp.id
}