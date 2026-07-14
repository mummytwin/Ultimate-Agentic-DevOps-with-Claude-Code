# Assignment 4 — Written Answers
**Name: Hope Odu**

## Q1: Why does the cost optimizer use Haiku instead of Sonnet?
The cost optimizer uses Haiku because Haiku is significantly faster and cheaper than Sonnet, and this task does not require deep reasoning or complex analysis. Speed and cost-efficiency matter here because cost checks may run frequently.

## Q2: Why does the security auditor NOT have Write in its tools list?
The security auditor is a read-only agent by design — it only needs to read files and grep for patterns to identify security issues. Giving it Write access would violate the principle of least privilege and create unnecessary risk.

## Q3: Why does the tf-writer use `inherit` instead of a specific model?
The tf-writer uses inherit because it needs to match whatever model the orchestrating agent is already using. Since writing Terraform code requires the same reasoning capability as the parent task that triggered it, inheriting the model ensures consistency and avoids capability mismatches.
