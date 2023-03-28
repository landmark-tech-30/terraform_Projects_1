resource "random_integer" "bucket_number" {
  min = 1
  max = 50000
}


resource "aws_s3_bucket" "mybucket" {
  bucket = format("bootcamp30-%s-%s", random_integer.bucket_number, var.name)

}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

