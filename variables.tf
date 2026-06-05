variable "aws_region" {
  description = "AWS region where all resources will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project name used for resource naming and tagging. Keep short — combined with environment and suffix it must not exceed 33 characters."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,19}$", var.project))
    error_message = "project must start with a lowercase letter, contain only lowercase letters, numbers, or hyphens, and be at most 20 characters."
  }
}

variable "environment" {
  description = "Deployment environment name (e.g., dev, staging, prod)."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "vpc_id" {
  description = "ID of the VPC where ElastiCache resources will be deployed."
  type        = string
  nullable    = false
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ElastiCache subnet group. Must belong to the specified vpc_id."
  type        = list(string)
  nullable    = false

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnets in different Availability Zones are required."
  }
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed inbound access to the ElastiCache cluster on the Redis port."
  type        = list(string)
  default     = []
}

variable "allowed_security_group_ids" {
  description = "Security group IDs whose members are allowed inbound access to the ElastiCache cluster."
  type        = list(string)
  default     = []
}

variable "node_type" {
  description = "ElastiCache node instance type."
  type        = string
  default     = "cache.t4g.micro"
}

variable "num_cache_clusters" {
  description = "Total number of cache clusters in the replication group (1 = primary only; 2+ = primary + replicas). Automatic failover requires at least 2."
  type        = number
  default     = 2

  validation {
    condition     = var.num_cache_clusters >= 1 && var.num_cache_clusters <= 6
    error_message = "num_cache_clusters must be between 1 and 6."
  }
}

variable "engine_version" {
  description = "Redis OSS engine version. Must be 7.x or later for in-transit encryption modification support."
  type        = string
  default     = "7.1"
}

variable "port" {
  description = "Port on which the ElastiCache cluster accepts connections."
  type        = number
  default     = 6379
}

variable "automatic_failover_enabled" {
  description = "Enable automatic failover to a replica when the primary node fails. Requires num_cache_clusters >= 2."
  type        = bool
  default     = true
}

variable "multi_az_enabled" {
  description = "Enable Multi-AZ deployment for automatic cross-zone failover."
  type        = bool
  default     = true
}

variable "at_rest_encryption_enabled" {
  description = "Enable encryption at rest using AES-256."
  type        = bool
  default     = true
}

variable "maintenance_window" {
  description = "Weekly time window (UTC) for scheduled cluster maintenance. Format: ddd:hh24:mi-ddd:hh24:mi."
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "snapshot_retention_limit" {
  description = "Number of days to retain automatic daily snapshots. Set to 0 to disable automatic snapshots."
  type        = number
  default     = 7

  validation {
    condition     = var.snapshot_retention_limit >= 0 && var.snapshot_retention_limit <= 35
    error_message = "snapshot_retention_limit must be between 0 and 35."
  }
}

variable "snapshot_window" {
  description = "Daily UTC time range during which ElastiCache begins taking snapshots. Format: hh24:mi-hh24:mi."
  type        = string
  default     = "03:00-04:00"
}

variable "secret_recovery_window_days" {
  description = "Number of days Secrets Manager waits before permanently deleting a secret. Set to 0 for immediate deletion (not recommended for production)."
  type        = number
  default     = 7

  validation {
    condition     = var.secret_recovery_window_days == 0 || (var.secret_recovery_window_days >= 7 && var.secret_recovery_window_days <= 30)
    error_message = "secret_recovery_window_days must be 0 or between 7 and 30."
  }
}

variable "tags" {
  description = "Additional tags merged onto all taggable resources."
  type        = map(string)
  default     = {}
}
