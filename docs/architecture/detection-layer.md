# Detection Layer Design (Plan-Only)

## Goals
- Record all account activity (CloudTrail)
- Detect suspicious behavior (GuardDuty)
- Centralize logs securely (S3 + KMS)
- Support SOC workflows (alerts + triage)

## Components
1. CloudTrail (multi-region, management events on)
2. S3 log bucket (KMS encrypted, TLS-only, public access blocked)
3. GuardDuty enabled (all regions recommended)
4. CloudWatch alarms (later) + SIEM forwarding (later)

## Key Detections to Enable
- IAM policy changes / access key creation
- AssumeRole anomalies
- VPC/SG/NACL/route table changes
- S3 public access / policy changes
- Unusual API calls and data exfil patterns (GuardDuty)

## Evidence Sources
- CloudTrail → S3 (primary audit)
- VPC Flow Logs → CloudWatch (network evidence)
- GuardDuty findings → Security Hub/SIEM (future)

## Next Implementation Step (when ready)
- Add a `modules/detection-baseline` Terraform module
- Wire it into `environments/aws/dev`
- Plan → review → apply (controlled)
