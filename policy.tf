data "aws_iam_policy_document" "nuon_ecr_access" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
      "ecr:GetDownloadUrlForLayer",
      "ecr:DescribeImageReplicationStatus",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeImages",
      "ecr:DescribePullThroughCacheRules",
      "ecr:DescribeRegistry",
      "ecr:DescribeRepositories",
    ]
    resources = var.repository_arns
  }
}

resource "aws_iam_policy" "nuon_ecr_access" {
  name   = var.policy_name
  policy = data.aws_iam_policy_document.nuon_ecr_access.json
}
