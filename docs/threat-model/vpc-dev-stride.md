# VPC Threat Model (Dev Landing Zone)

## Scope
- VPC, public/private subnets, IGW, NAT (if enabled), routing
- VPC Flow Logs to CloudWatch Logs
- Log bucket encrypted with KMS (S3 + KMS)

## Trust Boundaries
1. Internet ↔ Public Subnets
2. Public ↔ Private Subnets
3. Private ↔ Internet (via NAT)
4. VPC ↔ Logging destinations (CloudWatch / S3)

## Key Assets
- Workloads in private subnets
- IAM roles/credentials used by workloads
- Network controls (SGs/NACLs/route tables)
- Logs (Flow Logs, CloudTrail later)
- S3 log bucket + KMS key

## STRIDE Table

| STRIDE | Example Threat in This VPC | Impact | Mitigations (Controls) | Evidence/Detection |
|---|---|---|---|---|
| Spoofing | SSRF to steal instance credentials (IMDS) | Account/resource compromise | Enforce IMDSv2, least-privilege instance roles, private subnets | VPC Flow Logs + CloudTrail (later) |
| Tampering | Route tables/SGs modified to open access | Exposure/exfiltration | Terraform + Git review, Config rules, SCPs | CloudTrail alerts on network changes |
| Repudiation | Attacker claims changes weren’t them | Weak auditability | Centralized logs, retention | CloudTrail + log integrity controls |
| Info Disclosure | Publicly exposed service/data path | Data leak | Private subnets, restrict SGs, S3 Public Access Block, TLS-only | VPC Flow Logs, S3 access logs (later) |
| DoS | Flood public endpoint, NAT saturation | Outage | Multi-AZ, WAF/Shield (later), alarms | CloudWatch metrics/alarms |
| Elevation of Privilege | Over-permissive IAM role used by workload | Full takeover | Least privilege, permission boundaries (later) | CloudTrail IAM anomaly detections |

## Notes
- Current phase: baseline controls + wiring
- Next phase: add CloudTrail, central log bucket policy hardening, detection rules, and incident runbooks

## Data Flow Diagram (Text Representation)

Internet
   ↓
Public Subnets (future ALB / Bastion)
   ↓
Private Subnets (Application workloads)
   ↓
NAT Gateway (outbound only)
   ↓
Internet

VPC Flow Logs → CloudWatch Logs
CloudWatch Logs → (future) Central S3 Log Bucket (KMS encrypted)

## Realistic Attack Scenarios

1. SSRF attack against public workload retrieving instance metadata credentials.
2. Overly permissive security group exposing SSH/RDP.
3. Compromised IAM role used for S3 data exfiltration.
4. Route table modification enabling unintended internet access.
5. Logging disabled to evade detection.

## Security Controls Already Implemented

| Control | Where Implemented |
|----------|------------------|
| Network Segmentation | Public/Private Subnets |
| Egress Control | NAT Gateway |
| Encryption at Rest | KMS for S3 |
| TLS Enforcement | S3 Bucket Policy |
| Logging | VPC Flow Logs |
| Change Management | Terraform + Git |


## IAM Privilege Escalation Abuse Case (High Risk)

### Scenario
1. Attacker exploits public-facing entry point (future ALB/app) and gains code execution.
2. Attacker queries instance/container credentials (IMDS/IRSA/Task role).
3. Role is over-permissive (e.g., iam:PassRole, iam:CreatePolicy, iam:AttachUserPolicy).
4. Attacker escalates privileges and modifies networking/logging to persist and evade.

### Impact
- Full account compromise
- Network reconfiguration for persistence/exfiltration
- Logging tampering

### Mitigations
- Enforce least privilege on workload roles (no IAM write permissions)
- Block dangerous IAM actions with SCPs/permission boundaries:
  - iam:PassRole (restrict by condition keys)
  - iam:CreatePolicy / iam:AttachRolePolicy
  - iam:PutRolePolicy
- Use IMDSv2, disable hop limit misconfigs
- Separate “break-glass/admin” roles from workload roles

### Detection
- CloudTrail alerts on IAM policy changes, PassRole usage, new access keys
- GuardDuty findings for unusual API calls / credential abuse
- SIEM correlation: new policy + network change + log disable attempts
