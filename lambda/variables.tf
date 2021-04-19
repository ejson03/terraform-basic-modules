variable "lambda_payload_filename" {}
variable "lambda_function_handler" {}
variable "lambda_runtime" {}
variable "lambda_role" {}
variable "lambda_grant_permission" {
  type = bool
  default = false
}
variable "lambda_statement_id" {
  type = string
  default = ""
}
variable "lambda_principal" {
  type = string
  default = ""
}
variable "lambda_source_arn" {
  type = string
  default = ""
}