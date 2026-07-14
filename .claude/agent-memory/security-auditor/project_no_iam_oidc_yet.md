---
name: project-no-iam-oidc-yet
description: As of 2026-07-13, terraform/ contains no aws_iam_role/OIDC provider resources — only S3+CloudFront
metadata:
  type: project
---

As of the 2026-07-13 audit, `terraform/` (providers.tf, outputs.tf, variables.tf, backend.tf, main.tf)
defines only: an S3 bucket + public access block + ownership controls, a CloudFront distribution with
an Origin Access Control, and the S3 bucket policy granting CloudFront read access. There are no
`aws_iam_role`, `aws_iam_policy`, or `aws_iam_openid_connect_provider` resources anywhere in the repo
(a repo-wide grep for `aws_iam_role|assume_role_policy|oidc` only matched an agent definition doc, not
actual terraform).

**Why:** The security-auditor checklist includes IAM least-privilege and OIDC trust-policy scoping
requirements, but these are currently not assessable because the resources don't exist yet — likely
because GitHub Actions deployment credentials/roles haven't been added to Terraform yet (may be
manually configured, or not yet built).

**How to apply:** Don't report "missing IAM policy" as a finding against main.tf; instead note in
audits that IAM/OIDC review is N/A until such resources are added, and re-run the IAM/OIDC checklist
items as soon as a `.tf` file defining a GitHub Actions OIDC role appears in `terraform/`.
