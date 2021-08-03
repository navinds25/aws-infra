
resource "aws_security_group" "worker_group1_sg" {
  name_prefix = "worker_group1_sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"

    cidr_blocks = [
      "106.51.130.30/31"
    ]
  }
}
