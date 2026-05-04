# Terraform AWS ECR Access

A module for setting up ECR access for [container image](https://docs.nuon.co/guides/container-image-components#aws-ecr-access-iam-role) components on Nuon. This module is published to the [Terraform Registry](https://registry.terraform.io/modules/nuonco/ecr-access/aws).

## Usage

To setup the IAM role granting access to Nuon-hosted (AWS) installs to pull images from an ECR repository, use the following snippet:

```hcl
module "nuon_aws_ecr_access" {
  source = "nuonco/ecr-access/aws"

  repository_arns = ["<repository-arn>"]
}
```

### Customers running self-hosted Nuon on GCP

If some of your customers run [self-hosted Nuon on GCP](https://docs.nuon.co/guides/self-hosted/gcp), pass each customer's
ctl-api service account so the trust policy also accepts their GCP-issued OIDC tokens:

```hcl
module "nuon_aws_ecr_access" {
  source = "nuonco/ecr-access/aws"

  repository_arns = ["<repository-arn>"]

  gcp_principals = [
    {
      service_account_unique_id = "123456789012345678901"
      service_account_email     = "ctl-api-<install>@<customer-project>.iam.gserviceaccount.com"
    },
  ]
}
```

The `service_account_unique_id` is the 21-digit numeric ID of the SA. Customers can find it with:

```bash
gcloud iam service-accounts describe <email> --format='value(uniqueId)'
```

This is additive — the role still accepts the default Nuon-hosted (AWS) principal.
