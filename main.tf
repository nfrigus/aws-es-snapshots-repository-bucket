resource "aws_s3_bucket" "snapshots" {
  bucket = var.snapshot_bucket_name
}

resource "aws_iam_role" "snapshots" {
  name = var.snapshot_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Condition = {
        ArnLike = { "aws:SourceArn" = var.aws_opensearch_domain_arn }
      }
      Effect    = "Allow"
      Principal = { Service = "es.amazonaws.com" }
    }]
  })

  inline_policy {
    name = "SnapshotsBucketAccess"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Action   = ["s3:ListBucket"]
        Effect   = "Allow"
        Resource = [aws_s3_bucket.snapshots.arn]
        }, {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.snapshots.arn}/*"]
      }]
    })
  }
}
