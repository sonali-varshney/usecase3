output "pubsubnet"{
    value = aws_subnet.pubsubnet[*].id
}

output "vpcid"{
    value = aws_vpc.vpcdemo.id
}

output "prvsubnet"{
    value = aws_subnet.prv_subnet[*].id
}