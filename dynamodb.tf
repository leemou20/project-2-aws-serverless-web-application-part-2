resource "aws_dynamodb_table" "leetable" {
  name         = "leetable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "email"

  attribute {
    name = "email"
    type = "S"
  }
}
