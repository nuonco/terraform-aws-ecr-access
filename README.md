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

If some of your customers run [self-hosted Nuon on GCP](https://docs.nuon.co/guides/self-hosted/gcp), pass each
customer's GCP service account unique IDs via `gcp_principals` so the trust policy also accepts their GCP-issued OIDC
tokens. Two SAs from the customer's project need to be listed:

- The org runner SA (display name `Nuon org runner <org_id>`) — pulls source for builds.
- The ctl-api SA (display name `ctl-api for <install_id>`) — fetches image metadata for `external_image` components.

```hcl
module "nuon_aws_ecr_access" {
  source = "nuonco/ecr-access/aws"

  repository_arns = ["<repository-arn>"]

  gcp_principals = [
    {
      service_account_unique_id = "123456789012345678901" # org runner SA UID
      service_account_email     = "<org-id-truncated>@<customer-project>.iam.gserviceaccount.com"
    },
    {
      service_account_unique_id = "987654321098765432109" # ctl-api SA UID
      service_account_email     = "ctl-api-<install-id-truncated>@<customer-project>.iam.gserviceaccount.com"
    },
  ]
}
```

`service_account_email` is documentation-only; the trust policy is anchored on `service_account_unique_id` (the SA's
21-digit numeric `uniqueId`). Customers can look both up with:

```bash
gcloud iam service-accounts list \
  --project=<customer-project> \
  --filter='displayName~"Nuon org runner" OR displayName~"ctl-api for"' \
  --format='table(email,uniqueId,displayName)'
```

Don't try to construct the SA emails by hand — Nuon truncates the org/install ID to fit GCP's 30-character SA name
limit, and the truncation length varies by prefix. The full org/install ID is preserved in each SA's display name.

This is additive — the role still accepts the default Nuon-hosted (AWS) principal.
