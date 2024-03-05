# Terraform AWS ECR Access

A module for setting up ECR access for [container image](https://docs.nuon.co/guides/container-image-components#ecr-access-iam-role) components on Nuon. This module is published to the [Terraform Registry](https://registry.terraform.io/modules/nuonco/ecr-access/aws).

## Usage

To setup the IAM role granting access to Nuon to pull images from an ECR repository, please use the following snippet:

```hcl
module "nuon_aws_ecr_access" {
  source = "nuonco/ecr-access/aws"

  repository_arns = ["<repository-arn>"]
}
```
