resource "aws_lambda_function" "handler_function" {
    function_name = "handler_function"
    filename = var.lambda_payload_filename
    role = var.lambda_role
    handler = var.lambda_function_handler
    source_code_hash = base64sha256(filebase64(var.lambda_payload_filename))
    runtime = var.lambda_runtime 
}

resource "aws_lambda_permission" "handler_permission"{
    count = var.lambda_grant_permission ? 1 : 0
    statement_id = var.lambda_statement_id
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.handler_function.function_name
    principal = var.lambda_principal
    source_arn = var.lambda_source_arn
}