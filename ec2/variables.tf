variable "instance_type" {
  default = "t2.micro"
}

variable "region" {
  default = "ap-south-1"
}

variable "key_name" {}

variable "subnets" {
  type = list(string)
}

variable "subnet_azs" {
  type = list(string)
  default = ["ap-south-1a", "ap-south-1b" ]
}
variable "vpc_security_group_id" {}

variable "template_file" {
  default = ""
}

variable "create_user_data" {
  default = false
}

variable "instance_count" {
  default = 1
}
