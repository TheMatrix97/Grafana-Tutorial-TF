output "instance_public_dns" {
    value = aws_instance.grafana_stack.public_dns
}