aws-es-snapshots-repository-bucket
===

This is a sample terraform module for creating S3 bucket with appropriate IAM Role to use it as ElasticSearch snapshots repository.

Usage
---

```hcl
module "snapshots" {
  source = "."

  aws_opensearch_domain_arn = "..."
  snapshot_bucket_name = "..."
  snapshot_role_name = "..."
}
```

Output
---

Outputs can be directly used as settings for repository registration.

```bash
terraform output -json | jq .snapshots.value
```
