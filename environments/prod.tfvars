project     = "fjfs-redis"
environment = "prod"
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

# ── Logs ──────────────────────────────────────────────────────────────────────
log_retention_days = 90

# ── Tags ──────────────────────────────────────────────────────────────────────
tags = {
  Team        = "platform"
  CostCenter  = "engineering"
  Criticality = "high"
}
