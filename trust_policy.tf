locals {
  default_principals = [
    "arn:aws:iam::814326426574:root",
  ]
  support_principals = [
    // NOTE: the following trust policies are setup to help the Nuon team do
    // support on any installs.
    "arn:aws:iam::766121324316:root",
  ]

  principals = var.enable_support_access ? concat(local.default_principals, local.support_principals) : local.default_principals
}

data "aws_iam_policy_document" "nuon_ecr_access_trust" {
  statement {
    sid    = "NuonHostedAWS"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "AWS"
      identifiers = local.principals
    }
  }

  dynamic "statement" {
    for_each = length(var.gcp_principals) > 0 ? [1] : []
    content {
      sid    = "SelfHostedGCP"
      effect = "Allow"
      actions = [
        "sts:AssumeRoleWithWebIdentity",
      ]
      principals {
        type        = "Federated"
        identifiers = ["accounts.google.com"]
      }
      condition {
        test     = "StringEquals"
        variable = "accounts.google.com:aud"
        values   = ["sts.amazonaws.com"]
      }
      condition {
        test     = "StringEquals"
        variable = "accounts.google.com:sub"
        values   = [for p in var.gcp_principals : p.service_account_unique_id]
      }
    }
  }
}
