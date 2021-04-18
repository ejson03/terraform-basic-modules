# resource "aws_security_group" "sg" {
#   name   = "project-sg"
#   vpc_id = var.vpc_id
#   tags = {
#     Name = "project-allowance"
#   }
# }

# resource "aws_security_group_rule" "inbound_ssh" {
#   from_port         = 22
#   protocol          = "tcp"
#   security_group_id = aws_security_group.sg.id
#   to_port           = 22
#   type              = "ingress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "inbound_http" {
#   from_port         = 80
#   protocol          = "tcp"
#   security_group_id = aws_security_group.sg.id
#   to_port           = 80
#   type              = "ingress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "outbound_all" {
#   from_port         = 0
#   protocol          = "-1"
#   security_group_id = aws_security_group.sg.id
#   to_port           = 0
#   type              = "egress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

resource "aws_security_group" "sg" {
  name        = "project_allowance_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      =  var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project-allowance"
  }
}