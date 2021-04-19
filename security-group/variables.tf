variable "vpc_id" {
  description = "ID of vpc created"
  type        = string
  default     = ""
}

variable "manage_security_group" {
  description = "Should be true to adopt and manage security group"
  type        = bool
  default     = false
}

variable "security_group_name" {
  description = "Name to be used on the security group"
  type        = string
  default     = "default"
}

variable "security_group_ingress" {
  description = "List of maps of ingress rules to set on the security group"
  type        = list(map(string))
  default     = null
}

variable "security_group_egress" {
  description = "List of maps of egress rules to set on the security group"
  type        = list(map(string))
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

