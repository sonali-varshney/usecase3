variable "target_group_port" {
  description = "The port on which the target group will listen"
  type        = number
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "protocol" {
  description = "The protocol used by the target group"
  type        = string
}

variable "health_check_path" {
  description = "The path for health checks"
  type        = string
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "alb_sec_gp" {
  description = "The security group for the ALB"
  type        = string
}

variable "pub_cidr_block" {
  description = "The public CIDR block"
  type        = string
}

variable "pubsubnet" {
  description = "The public subnets"
  type        = list(string)
}
variable "listener_port" {
  description = "The port on which the listener will listen"
  type        = number
}
variable "listener_protocol" {
  description = "The protocol used by the listener"
  type        = string
}
variable "ec2_id" {
  description = "The ID of the EC2 instance to attach to the target group"
  type        = string
}