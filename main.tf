resource "aws_instance" "http_service" {
  ami           = var.http_service_ami
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  tags = {
    Name = "HTTP Service"
  }

  vpc_security_group_ids = [aws_security_group.http_service_sg.id]
}

resource "aws_instance" "worker" {
  ami           = var.worker_ami
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  tags = {
    Name = "Worker Service"
  }

  vpc_security_group_ids = [aws_security_group.worker_sg.id]
}

resource "aws_security_group" "http_service_sg" {
  name        = "http_service_sg"
  description = "Security group for HTTP service in ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "worker_sg" {
  name        = "worker_sg"
  description = "Security group for worker service"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.http_service_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
