project     = "fjfs-redis"
environment = "staging"
aws_region  = "us-east-1"

# ── Existing Network ──────────────────────────────────────────────────────────
vpc_id = "vpc-06400873e4e80e8aa"
subnet_ids = [
  "subnet-08d77d26695897600", # AZ-A private
  "subnet-02fea0639de5bff1b", # AZ-B private
  "subnet-0363a8445db432cb5", # AZ-C private
]

#allowed_security_group_ids = ["sg-xxxxxxxxxxxxxxxxx"]
allowed_cidr_blocks        = ["10.0.0.0/16", "192.168.0.0/24"]

# ── Sizing ────────────────────────────────────────────────────────────────────
# One primary + one replica; mirrors prod topology at reduced cost.
node_type          = "cache.t4g.small"
num_cache_clusters = 2
engine_version     = "7.1"

# ── High Availability ─────────────────────────────────────────────────────────
automatic_failover_enabled = true
multi_az_enabled           = true

# ── Encryption ────────────────────────────────────────────────────────────────
at_rest_encryption_enabled = true

# ── Maintenance & Backups ─────────────────────────────────────────────────────
maintenance_window       = "sat:05:00-sat:06:00"
snapshot_retention_limit = 3
snapshot_window          = "03:00-04:00"

# ── Secrets Manager ───────────────────────────────────────────────────────────
secret_recovery_window_days = 7

# ── Logs ──────────────────────────────────────────────────────────────────────
log_retention_days = 30

# ── Tags ──────────────────────────────────────────────────────────────────────
tags = {
  Team       = "platform"
  CostCenter = "engineering"
}
