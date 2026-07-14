---
name: project-portfolio-risk-context
description: This repo's terraform provisions a static HTML/CSS-only portfolio site (no JS, no backend, no user data) on S3+CloudFront
metadata:
  type: project
---

The `terraform/` directory in this repo provisions a purely static portfolio website (pure HTML5/CSS3,
no JavaScript, no build step, no framework, no user input, no auth, no PII) served via S3 (private,
OAC-fronted) + CloudFront. See project CLAUDE.md.

**Why:** This context matters for severity calibration during security audits. Because there is no
user data, no auth, and no dynamic backend, issues like "no WAF attached" or "no S3 access logging"
are real gaps worth flagging but are MEDIUM/LOW rather than CRITICAL/HIGH — the blast radius of a
compromise is limited to defacement of a public static site, not data exposure. Conversely, issues
that affect the integrity of the deployment pipeline or expose Terraform state (which could contain
account IDs/ARNs or, if the project grows, real secrets) should be rated more strictly, since state
mishandling risk doesn't shrink just because the site content is low-sensitivity.

**How to apply:** When rating findings in this repo, keep S3/CloudFront content-exposure findings at
MEDIUM/LOW baseline unless they'd allow write access, bucket takeover, or origin bypass (those stay
HIGH/CRITICAL). Keep state-handling, credential-handling, and IAM/OIDC findings at their normal
severity regardless of the site's low content sensitivity — see [[project-no-iam-oidc-yet]].
