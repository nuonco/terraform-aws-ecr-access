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
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
    type = "AWS"
    identifiers = local.principals
    }
  }
}
