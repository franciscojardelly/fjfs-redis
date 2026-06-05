bucket         = "fjfs-infra"
key            = "redis/dev/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "myapp-terraform-state-lock"
