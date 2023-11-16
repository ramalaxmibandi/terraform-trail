 #instance.tf
resource "aws_instance" "master" {
  ami           = "ami-0ff1c68c6e837b183"
  instance_type = "t2.micro"
  count         = 1
  tags = {
    Name = "master"
  }
}

resource "aws_instance" "worker" {
  ami           = "ami-0ff1c68c6e837b183"
  instance_type = "t2.micro"
  count         = 2
  tags = {
    Name = "worker-${count.index + 1}"
  }
}
output "master_ips" {
  value = aws_instance.master.*.private_ip
}

output "worker_ips" {
  value = aws_instance.worker.*.private_ip
}