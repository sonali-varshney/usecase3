variable "subnet_id"{}

variable "pub_cidr_block"{}

variable "ami"{} #"ami-00ca32bbc84273381"
variable "instance_type"{} #"t3.micro"
variable "web_sec_gp_name"{} #"web_sec_gp"
variable "ec2_sec_gp_name"{} #"ec2_secgp"
variable "subnet_pub_id"{
  description = "List of public subnet IDs"
  type        = list(string)
  }
variable "ec2_sec_gp"{}