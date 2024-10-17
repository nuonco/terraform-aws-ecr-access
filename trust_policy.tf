data "aws_iam_policy_document" "nuon_ecr_access_trust" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        // TODO: we plan on consolidating to a single vendor IAM role for each tenant, meaning this will be only a
        // single account to trust.
        "arn:aws:iam::676549690856:root",
        "arn:aws:iam::007754799877:root",
        "arn:aws:iam::017820687303:root",
        "arn:aws:iam::017820687331:root",
      ]
    }
  }
}
