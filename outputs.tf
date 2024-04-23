output "http_service_instance_id" {
  value = aws_instance.http_service.id
}

output "worker_instance_id" {
  value = aws_instance.worker.id
}
