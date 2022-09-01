resource "aws_secretsmanager_secret" "secretsmanager" {
  name = var.name
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.secretsmanager.id
  secret_string = jsonencode(var.example)
}

variable "example" {
  default = {
    key1 = "value1"
    key2 = "value2"
  }

  type = map(string)
}

