---
name: project-recurring-terraform-gaps
description: Concrete gaps found in terraform/ — first seen 2026-07-13, reconfirmed 2026-07-14; check these haven't regressed on future passes
metadata:
  type: project
---

As of the 2026-07-14 re-audit of `terraform/main.tf`, `backend.tf`, `providers.tf`, `variables.tf`,
`outputs.tf`, the two original gaps from 2026-07-13 are STILL OPEN, plus a set of checklist gaps
newly cataloged this pass. Quick re-check list for future audits:

1. **`.gitignore` doesn't cover Terraform state/vars.** Repo root `.gitignore` only lists `.terraform`
   and `.terraform.lock.hcl`. `backend.tf` intentionally runs on local state during bootstrap (see
   its comment block), so `terraform.tfstate` can exist on disk and isn't excluded from git —
   `*.tfstate`, `*.tfstate.*`, and `*.tfvars` are all missing from `.gitignore`. (HIGH — state/secret
   exposure risk per [[project_portfolio_risk_context]].)
2. **CloudFront cert/alias mismatch risk.** `main.tf`'s `aws_cloudfront_distribution.site` sets
   `aliases` conditionally from `var.domain_name` but hardcodes
   `viewer_certificate { cloudfront_default_certificate = true }` unconditionally. CloudFront requires
   an ACM cert (not the default cert) whenever aliases are non-empty, so this breaks the moment
   `domain_name` is set. Also no `minimum_protocol_version` is set anywhere. (HIGH.)
3. **No `aws_s3_bucket_versioning` resource** on `aws_s3_bucket.site` — no recovery from accidental
   overwrite/delete. (MEDIUM/LOW, availability not exposure.)
4. **No `aws_s3_bucket_server_side_encryption_configuration`** — AWS applies SSE-S3 by default now so
   not an active exposure, but it's implicit/unenforced in code. (MEDIUM/LOW.)
5. **No S3 access logging, no CloudFront `logging_config`, no WAF (`web_acl_id`)** on the distribution.
   (LOW per [[project_portfolio_risk_context]] — static no-auth site, blast radius limited.)
6. **No `aws_cloudfront_response_headers_policy`** — missing CSP/X-Frame-Options/HSTS/etc. security
   headers entirely. (MEDIUM — explicit checklist item, currently zero headers configured.)
7. **`backend.tf`'s commented bootstrap block uses `use_lockfile = true`** (needs Terraform >= 1.10)
   but `providers.tf` `required_version` only requires `>= 1.5` — inconsistency to flag as LOW if
   backend block is ever uncommented as-is.

**Why:** These are quick, mechanical checks (grep `.gitignore` for `tfstate`; grep `main.tf` for
`cloudfront_default_certificate` vs `aliases`; grep for `versioning|server_side_encryption|logging|
web_acl|response_headers|minimum_protocol_version` — all returned zero matches on 2026-07-14) that
catch real risk without needing to re-derive them from scratch each time.

**How to apply:** On future terraform/ audits, re-verify each item is still present/absent before
re-reporting — if fixed, drop from findings; if still open, items 1-2 are fast HIGH-severity wins to
flag first, item 6 is the next-most-actionable MEDIUM. Related: [[project_no_iam_oidc_yet]],
[[project_portfolio_risk_context]].
