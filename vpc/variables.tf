variable "region" {
  default = "ap-south-1"
}
variable "public_cidr" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "subnet_azs" {
  type = list(string)
  default = ["ap-south-1a", "ap-south-1b" ]
}
variable "private_cidr" {
  type = list(string)
  default = []
}
variable "vpc_cidr" {
}
