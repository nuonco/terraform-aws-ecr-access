module "nuon_ecr_access" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = ">= 5.1.0"

  create_role = true

  role_name = var.role_name

  allow_self_assume_role   = false
  custom_role_trust_policy = data.aws_iam_policy_document.nuon_ecr_access_trust.json
  create_custom_role_trust_policy = true
  custom_role_policy_arns = [
    aws_iam_policy.nuon_ecr_access.arn
  ]
}
