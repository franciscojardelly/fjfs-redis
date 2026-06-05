terraform {
  backend "s3" {
    # Configured per environment via -backend-config flag:
    #   terraform init -backend-config="environments/backend-dev.hcl"
    #
    # Required infrastructure (create once, shared across environments):
    #   - S3 bucket with versioning and server-side encryption enabled
    #   - DynamoDB table (billing_mode = PAY_PER_REQUEST, hash key = "LockID" / String)
  }
}
