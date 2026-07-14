# Security Auditor Memory Index

- [Read-only audit mode](feedback_read_only_audits.md) — deliver findings as text only, never edit terraform/ files during an audit unless explicitly asked to fix
- [Portfolio site risk calibration](project_portfolio_risk_context.md) — static no-JS/no-user-data site; calibrate severity down for WAF/logging, up for state/secrets exposure
- [No IAM/OIDC resources yet in terraform/](project_no_iam_oidc_yet.md) — checklist items about OIDC/IAM don't yet apply; re-check when added
- [Recurring terraform gaps](project_recurring_terraform_gaps.md) — .gitignore missing tfstate/tfvars; CloudFront default-cert + alias mismatch, no min TLS version
