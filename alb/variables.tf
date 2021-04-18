variable "vpc_id" {}
variable "security_group_id" {}
variable "subnet" {
  type = list(string)
}