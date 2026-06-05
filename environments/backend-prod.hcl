bucket         = "myapp-terraform-state"
key            = "redis/prod/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "myapp-terraform-state-lock"
