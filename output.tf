#to display the EC2 instance's public IP address
output "instance_public_ip" {
  description = "Public IP address of EC2 server instance"
  value       = aws_instance.app_server.public_ip
}