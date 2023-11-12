resource "aws_s3_bucket" "event_planr_images" {
  bucket = "${local.environment}-event-planr-images-bucket"

  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "event_planr_images" {
  bucket = aws_s3_bucket.event_planr_images.id

  block_public_policy = false
  block_public_acls   = false
}

resource "aws_s3_bucket_policy" "event_planr_images" {
  bucket = aws_s3_bucket.event_planr_images.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.event_planr_images.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_cors_configuration" "event_planr_images" {
  bucket = aws_s3_bucket.event_planr_images.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}
