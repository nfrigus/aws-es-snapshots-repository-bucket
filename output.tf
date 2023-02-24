output "snapshots" {
  value = {
    type = "s3"
    settings = {
      bucket   = aws_s3_bucket.snapshots.bucket
      region   = aws_s3_bucket.snapshots.region
      role_arn = aws_iam_role.snapshots.arn
    }
  }
}
