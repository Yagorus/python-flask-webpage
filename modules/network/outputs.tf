output "vpc_id" {
  value = aws_vpc.main.id
}
output "aws_lb_target_group_arn" {
  value = aws_lb_target_group.target_group.id
}

output "load_balancer_ip" {
  value = aws_lb.load_balancer.dns_name
}

output "security_group_id" {
  value = aws_security_group.security_group_port_i80.id
}
output "service_security_group" {
  value = aws_security_group.service_security_group.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}
output "private_subnets" {
  value = aws_subnet.private.*.id
}