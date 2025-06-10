resource "aws_dynamodb_table" "table" {
  name         = "${local.name_prefix}-topmovies"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "year"

  attribute {
    name = "year"
    type = "N" # todo: fill with apporpriate value
  }

}
