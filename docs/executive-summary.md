# Cloud Security Foundations – Dev Landing Zone (Executive Summary)

## What was built (design + IaC)
- Segmented VPC with public and private subnets (multi-AZ)
- Controlled internet ingress/egress (IGW + NAT)
- Network telemetry via VPC Flow Logs
- Secure log storage design (S3 with KMS encryption, TLS-only, public access blocked)
- Threat model using STRIDE + realistic attack paths

## Why it matters
- Reduces attack surface by keeping workloads private
- Limits inbound exposure to controlled entry points
- Improves auditability with network + API activity logging
- Establishes reusable, version-controlled security baseline

## Top risks addressed
- Public exposure & lateral movement
- Credential theft paths (SSRF/metadata)
- Data exfiltration via outbound paths
- Log tampering / reduced visibility

## Next steps (no-cost / plan-only first)
- Implement CloudTrail + GuardDuty baseline module
- Add guardrails (AWS Config + SCPs)
- Add detection rules + incident runbooks
