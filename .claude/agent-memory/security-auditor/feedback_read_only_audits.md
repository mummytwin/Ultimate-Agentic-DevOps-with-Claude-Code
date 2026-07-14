---
name: feedback-read-only-audits
description: Terraform security audits in this repo should be read-only, reporting findings as text rather than editing files
metadata:
  type: feedback
---

When asked to audit `terraform/` for security issues, treat the task as read-only: report findings
(severity, resource, issue, why it matters, exact fix) as the final text response rather than
applying edits to the `.tf` files, even though the Edit tool is available.

**Why:** The task instructions explicitly called this out as a read-only audit, distinct from normal
remediation work. Users doing IaC review typically want to see the diff/recommendation before any
change lands, especially for infrastructure that provisions real AWS resources.

**How to apply:** Default to read-only reporting for any "audit"/"review" framed request against
`terraform/`. Only make direct edits if the user's phrasing clearly asks for fixes to be applied
(e.g. "fix these issues" rather than "audit"/"review").
