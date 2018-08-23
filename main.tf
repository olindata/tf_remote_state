resource "aws_s3_bucket" "remote_state" {
  bucket = "terraform-deploy-fragments-${var.accountid}-${var.region}"
  region = "${var.region}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = "${var.tags}"
}

resource "aws_s3_bucket_policy" "remote_state_cross_account" {
  count = "${var.create_cross_account_policy}"

  bucket = "${aws_s3_bucket.remote_state.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Cross account permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.authorised_accountid}:root"
            },
            "Action": [
                "s3:GetBucketLocation",
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::terraform-deploy-fragments-${var.accountid}-${var.region}",
                "arn:aws:s3:::terraform-deploy-fragments-${var.accountid}-${var.region}/*"
            ]
        }
    ]
}
POLICY
}
