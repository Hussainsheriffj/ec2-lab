resource "aws_instance" "ansible_server" {
  count = var.num_instances
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"

  vpc_security_group_ids = [aws_security_group.ansible_server.id]
  key_name = "talent-academy-lab"
  subnet_id = data.aws_subnet.Public.id

  tags = {
    Name = "Ansible Server ${count.index + 1}"
  }
}

resource "aws_eip" "ansible_server_ip" {
  count = var.num_instances
  instance = aws_instance.ansible_server[count.index].id
  vpc      = true
}