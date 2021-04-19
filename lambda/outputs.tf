output "lambda_arn" {
  value = aws_lambda_function.handler_function.invoke_arn
}

