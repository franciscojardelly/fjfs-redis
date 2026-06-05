project     = "myapp"
environment = "prod"
aws_region  = "us-east-1"

# ── Existing Network ──────────────────────────────────────────────────────────
vpc_id     = "vpc-xxxxxxxxxxxxxxxxx"
subnet_ids = [
  "subnet-xxxxxxxxxxxxxxxxx", # AZ-A private
  "subnet-yyyyyyyyyyyyyyyyy", # AZ-B private
  "subnet-zzzzzzzzzzzzzzzzz", # AZ-C private
]

allowed_security_group_ids = ["sg-xxxxxxxxxxxxxxxxx"]
allowed_cidr_blocks        = []

# ── Sizing ────────────────────────────────────────────────────────────────────
# Memory-optimized node with two replicas for read scalability and resilience.
node_type          = "cache.r7g.large"
num_cache_clusters = 3
engine_version     = "7.1"

# ── High Availability ─────────────────────────────────────────────────────────
automatic_failover_enabled = true
multi_az_enabled           = true

# ── Encryption ────────────────────────────────────────────────────────────────
at_rest_encryption_enabled = true

# ── Maintenance & Backups ─────────────────────────────────────────────────────
maintenance_window       = "tue:02:00-tue:03:00"
snapshot_retention_limit = 7
snapshot_window          = "00:00-01:00"

# ── Secrets Manager ───────────────────────────────────────────────────────────
secret_recovery_window_days = 7

# ── Tags ──────────────────────────────────────────────────────────────────────
tags = {
  Team        = "platform"
  CostCenter  = "engineering"
  Criticality = "high"
}
