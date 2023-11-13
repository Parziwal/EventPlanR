resource "aws_s3_bucket" "event_planr_frontend" {
  bucket        = "event-planr-frontend"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "event_planr_frontend" {
  bucket = aws_s3_bucket.event_planr_frontend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "event_planr_frontend" {
  depends_on = [aws_s3_bucket_ownership_controls.event_planr_frontend]

  bucket = aws_s3_bucket.event_planr_frontend.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "event_planr_frontend" {
  bucket = aws_s3_bucket.event_planr_frontend.id
  policy = data.aws_iam_policy_document.cloud_front_allow_access_policy.json
}

resource "aws_s3_bucket_website_configuration" "event_planr_frontend" {
  bucket = aws_s3_bucket.event_planr_frontend.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

data "aws_iam_policy_document" "cloud_front_allow_access_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.event_planr_frontend.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.event_planr_frontend.arn]
    }
  }
}
