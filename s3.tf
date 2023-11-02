resource "aws_s3_bucket" "bucket-artifact" {
  bucket = "ecs-artifactory-bucket"
  acl    = "private"
}