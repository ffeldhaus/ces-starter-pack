terraform {
  backend "gcs" {
    # Configuration will be provided via CLI during `terraform init`
    # Example: terraform init -backend-config="bucket=your-tf-state-bucket-name" \
    #                        -backend-config="prefix=ces-starter-pack/cymbal-retail/conversational-agents"
  }
}