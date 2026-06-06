resource "random_password" "auth_token" {
  length  = 64
  special = true

  # ElastiCache AUTH token: only !, &, #, $, ^, <, >, - are permitted as special chars
  override_special = "!&#$^<>-"
}

resource "aws_secretsmanager_secret" "auth_token" {
  name                    = "${var.project}-${var.environment}-redis-auth-token"
  description             = "Redis OSS AUTH token for the ${var.project} ${var.environment} ElastiCache replication group."
  recovery_window_in_days = var.secret_recovery_window_days

  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "auth_token" {
  secret_id     = aws_secretsmanager_secret.auth_token.id
  secret_string = random_password.auth_token.result

  lifecycle {
    ignore_changes = [secret_string]
  }
}
