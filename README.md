# infra-pipeline

A small CI/CD project: **GitHub Actions** runs **Terraform** (AWS EC2) and **Ansible** (Docker, Prometheus, Grafana), with a **security scan** gate and a provisioned **Grafana dashboard**.

```
push/PR -> lint (fmt, validate, ansible-lint)
        -> security (gitleaks, Trivy IaC, Checkov)
        -> terraform plan
        -> [manual, approval-gated] terraform apply -> ansible-playbook
```

## Layout
- `.github/workflows/ci.yml` – pipeline
- `terraform/` – EC2 instance, locked-down security group, IMDSv2, encrypted disk
- `ansible/` – installs Docker and deploys the monitoring stack
- `grafana/` – datasource/dashboard provisioning and `infra-overview.json`

## Setup
1. Create an AWS IAM role trusted for GitHub OIDC; add its ARN as secret `AWS_ROLE_ARN`.
2. Add secret `SSH_PRIVATE_KEY` (matching the public key in `terraform.tfvars`).
3. Provide variables via `TF_VAR_ssh_public_key` / `TF_VAR_admin_cidr` (repo variables or workflow env), or a local `terraform.tfvars` (see example).
4. Create a `production` environment with required reviewers.
5. Run the workflow manually with **apply = true** to deploy.

## Known gaps (deliberate, for a small project)
- No remote Terraform backend; add S3 + locking before real use.
- Grafana admin password file (`grafana_admin_password`) must be supplied, e.g. via Ansible Vault.
- Grafana is served over HTTP; put it behind TLS for anything beyond a demo.
