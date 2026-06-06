output "this_replication_group_id" {
  description = "ID of the ElastiCache replication group."
  value       = aws_elasticache_replication_group.this.id
}

output "this_replication_group_arn" {
  description = "ARN of the ElastiCache replication group."
  value       = aws_elasticache_replication_group.this.arn
}

output "this_replication_group_primary_endpoint_address" {
  description = "Primary endpoint address for read/write operations."
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "this_replication_group_reader_endpoint_address" {
  description = "Reader endpoint address that load-balances across all read replicas."
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
}

output "this_replication_group_port" {
  description = "Port number the replication group listens on."
  value       = aws_elasticache_replication_group.this.port
}

output "this_replication_group_engine_version_actual" {
  description = "Actual Redis engine version running on the cluster (may differ from requested if auto-patched)."
  value       = aws_elasticache_replication_group.this.engine_version_actual
}

output "this_subnet_group_name" {
  description = "Name of the ElastiCache subnet group."
  value       = aws_elasticache_subnet_group.this.name
}

output "this_security_group_id" {
  description = "ID of the security group attached to the ElastiCache cluster."
  value       = aws_security_group.this.id
}

output "this_security_group_arn" {
  description = "ARN of the security group attached to the ElastiCache cluster."
  value       = aws_security_group.this.arn
}

output "auth_token_secret_arn" {
  description = "ARN of the Secrets Manager secret storing the Redis AUTH token."
  value       = aws_secretsmanager_secret.auth_token.arn
}

output "auth_token_secret_name" {
  description = "Name of the Secrets Manager secret storing the Redis AUTH token."
  value       = aws_secretsmanager_secret.auth_token.name
}

output "this_slow_log_group_name" {
  description = "Name of the CloudWatch log group for Redis slow logs."
  value       = aws_cloudwatch_log_group.redis_slow_log.name
}

output "this_engine_log_group_name" {
  description = "Name of the CloudWatch log group for Redis engine logs."
  value       = aws_cloudwatch_log_group.redis_engine_log.name
}
