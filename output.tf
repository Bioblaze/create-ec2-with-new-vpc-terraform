output "server_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "server_subnet_id" {
    value = aws_subnet.ec2_subnet.id
}

output "server_vpc_id" {
    value = aws_vpc.ec2_vpc.id
}

output "server_security_group_id" {
    value = aws_security_group.ec2_security_group.id
}

output "internet_gateway_id" {
    value = aws_internet_gateway.ec2_gateway.id
}

output "route_table_id" {
    value = aws_route_table.ec2_route_table.id
}

output "os_installed_arn" {
    value = data.aws_ami.ec2_os_ami.arn
}

output "os_installed_id" {
    value = data.aws_ami.ec2_os_ami.id
}

output "ec2_key_pair_name" {
    value = aws_key_pair.ec2_key.key_name
}

output "ec2_key_pair_arn" {
    value = aws_key_pair.ec2_key.arn
}
output "ec2_key_pair_id" {
    value = aws_key_pair.ec2_key.key_pair_id
}