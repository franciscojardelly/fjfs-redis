project     = "fjfs-redis"
environment = "dev"
aws_region  = "us-east-1"

# ── Existing Network ──────────────────────────────────────────────────────────
vpc_id = "vpc-06400873e4e80e8aa"
subnet_ids = [
  "subnet-08d77d26695897600", # AZ-A private
  "subnet-02fea0639de5bff1b", # AZ-B private
  "subnet-0363a8445db432cb5", # AZ-C private
]

# Security groups allowed to reach the Redis port (e.g., application SG).
#allowed_security_group_ids = ["sg-xxxxxxxxxxxxxxxxx"]

# Optional: CIDR-based access (leave empty if using SG-only access).
allowed_cidr_blocks = ["10.0.0.0/16", "192.168.0.0/24"]

# ── Sizing ────────────────────────────────────────────────────────────────────
# Single node — no replica; minimizes cost in dev.
node_type          = "cache.t4g.micro"
num_cache_clusters = 1
engine_version     = "7.1"

# ── High Availability ─────────────────────────────────────────────────────────
# Disabled: auto-failover requires >= 2 nodes.
automatic_failover_enabled = false
multi_az_enabled           = false

# ── Encryption ────────────────────────────────────────────────────────────────
at_rest_encryption_enabled = true
# transit_encryption and auth_token are always enforced (hardcoded in main.tf).

# ── Maintenance & Backups ─────────────────────────────────────────────────────
maintenance_window       = "sun:05:00-sun:06:00"
snapshot_retention_limit = 1
snapshot_window          = "03:00-04:00"

# ── Secrets Manager ───────────────────────────────────────────────────────────
secret_recovery_window_days = 0 # immediate deletion allowed in dev

# ── Logs ──────────────────────────────────────────────────────────────────────
log_retention_days = 7

# ── Tags ──────────────────────────────────────────────────────────────────────
tags = {
  Team       = "platform"
  CostCenter = "engineering"
}
