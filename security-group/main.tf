resource "aws_security_group" "this" {
  count  = var.manage_security_group ? 1 : 0
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      description      = lookup(ingress.value, "description", null)
      from_port        = lookup(ingress.value, "from_port", 0)
      to_port          = lookup(ingress.value, "to_port", 0)
      protocol         = lookup(ingress.value, "protocol", "-1")
      cidr_blocks      = compact(split(",", lookup(ingress.value, "cidr_blocks", "")))
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      description      = lookup(egress.value, "description", null)
      from_port        = lookup(egress.value, "from_port", 0)
      to_port          = lookup(egress.value, "to_port", 0)
      protocol         = lookup(egress.value, "protocol", "-1")
      cidr_blocks      = compact(split(",", lookup(egress.value, "cidr_blocks", "")))
    }
  }

  tags = merge(
    {
      "Name" : format("%s", var.security_group_name)
    },
    var.tags,
  )
}
