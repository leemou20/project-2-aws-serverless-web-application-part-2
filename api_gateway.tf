resource "aws_api_gateway_rest_api" "api" {
name = "lee-demo-api-rest"
}


resource "aws_api_gateway_resource" "root" {
rest_api_id = aws_api_gateway_rest_api.api.id
parent_id = aws_api_gateway_rest_api.api.root_resource_id
path_part = "dev"
}


resource "aws_api_gateway_method" "get" {
rest_api_id = aws_api_gateway_rest_api.api.id
resource_id = aws_api_gateway_resource.root.id
http_method = "GET"
authorization = "NONE"
}


resource "aws_api_gateway_method" "post" {
rest_api_id = aws_api_gateway_rest_api.api.id
resource_id = aws_api_gateway_resource.root.id
http_method = "POST"
authorization = "NONE"
}


resource "aws_api_gateway_integration" "get_lambda" {
rest_api_id = aws_api_gateway_rest_api.api.id
resource_id = aws_api_gateway_resource.root.id
http_method = aws_api_gateway_method.get.http_method


integration_http_method = "POST"
type = "AWS_PROXY"
uri = aws_lambda_function.web_lambda.invoke_arn
}


resource "aws_api_gateway_integration" "post_lambda" {
rest_api_id = aws_api_gateway_rest_api.api.id
resource_id = aws_api_gateway_resource.root.id
http_method = aws_api_gateway_method.post.http_method


integration_http_method = "POST"
type = "AWS_PROXY"
uri = aws_lambda_function.web_lambda.invoke_arn
}

resource "aws_lambda_permission" "apigw" {
statement_id = "AllowAPIGatewayInvoke"
action = "lambda:InvokeFunction"
function_name = aws_lambda_function.web_lambda.function_name
principal = "apigateway.amazonaws.com"
source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "deployment" {
rest_api_id = aws_api_gateway_rest_api.api.id


depends_on = [
aws_api_gateway_integration.get_lambda,
aws_api_gateway_integration.post_lambda
]
}


resource "aws_api_gateway_stage" "stage" {
deployment_id = aws_api_gateway_deployment.deployment.id
rest_api_id = aws_api_gateway_rest_api.api.id
stage_name = "dev"
}


