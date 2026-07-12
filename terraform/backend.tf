# ----------------------------------------------------------------------------
# Remote state backend (S3)
# ----------------------------------------------------------------------------
# The backend is COMMENTED OUT intentionally. Terraform cannot use an S3
# backend that does not yet exist, so bootstrap in this order:
#
#   1. Run `terraform init` WITHOUT the backend block (as-is) to use local state.
#   2. Run `terraform apply` to create the resources (including a state bucket
#      if you choose to manage one here).
#   3. Uncomment the block below and set your state bucket / key / region.
#   4. Run `terraform init -migrate-state` to move local state into S3.
#
# terraform {
#   backend "s3" {
#     bucket       = "portfolio-site-tfstate"   # must already exist
#     key          = "portfolio-site/terraform.tfstate"
#     region       = "ap-south-1"
#     encrypt      = true
#     use_lockfile = true                       # S3-native state locking (TF >= 1.10)
#   }
# }
