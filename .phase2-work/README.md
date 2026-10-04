# Infrastructure KB

Validated procedures, configuration, and troubleshooting notes across Microsoft 365, Azure, AWS, Linux, and observability — and the baseline I build operational tooling against.

Each entry records its configuration, validation, and cleanup.
When an entry's manual checks are worth automating, the tool is built against the entry and graduates into its own repository.

```text
microsoft-365/   Intune policy, app packaging, and app deployment
azure/           compute, networking, PaaS, Key Vault, AKS, Terraform
aws/             EC2, Elastic Beanstalk, Secrets Manager
linux/           Ansible baseline, daily checks, health audit, deployment
observability/   Prometheus and Grafana monitoring stack on Docker
```

**What this is:** build records and procedures with recorded configuration and validation, plus the playbooks, scripts, and configuration they use.

**What this isn't:** procedures for a specific production environment, or summaries of vendor documentation.

## Context labels

Every entry states where the work was performed.

| Label | Meaning |
|---|---|
| Training sandbox | A provided lab environment (course platform) |
| Personal lab | My own tenant, subscription, account, or home lab |
| Production-derived | Based on production work, recreated in a lab and sanitized |


## Index

### Microsoft 365 — Intune

| Entry | Covers | Files | Context |
|---|---|---|---|
| [Edge startup policy](microsoft-365/intune/edge-startup-policy.md) | Microsoft Edge startup page configuration | — | Personal lab |
| [Windows Update rings](microsoft-365/intune/windows-update-rings.md) | Windows Update ring policy | — | Personal lab |
| [BitLocker encryption](microsoft-365/intune/bitlocker-encryption.md) | BitLocker endpoint encryption policy | — | Personal lab |
| [Defender Antivirus policy](microsoft-365/intune/defender-antivirus-policy.md) | Microsoft Defender Antivirus policy | — | Personal lab |
| [Wi-Fi profile](microsoft-365/intune/wifi-profile.md) | Wi-Fi profile deployment | — | Personal lab |
| [Trusted root certificate](microsoft-365/intune/trusted-root-certificate.md) | Trusted root certificate deployment | — | Personal lab |
| [Company Portal deployment](microsoft-365/intune/company-portal-deployment.md) | Company Portal app deployment | — | Personal lab |
| [Teams Win32 — packaging](microsoft-365/intune/teams-win32/01-packaging.md) | Packaging the Teams Bootstrapper as a Win32 app | — | Personal lab |
| [Teams Win32 — deployment](microsoft-365/intune/teams-win32/02-deployment.md) | Win32 app deployment, custom detection rule, pilot assignment | [`Detect-MicrosoftTeams.ps1`](microsoft-365/intune/teams-win32/Detect-MicrosoftTeams.ps1) | Personal lab |

### Azure

| Entry | Covers | Files | Context |
|---|---|---|---|
| [VM + NGINX](azure/vm-nginx.md) | VM provisioning, NGINX deployment, validation | — | Training sandbox |
| [App Service](azure/app-service.md) | App Service deployment | — | Training sandbox |
| [AKS cluster](azure/aks-cluster.md) | AKS cluster deployment | — | Training sandbox |
| [Key Vault](azure/key-vault.md) | Key Vault deployment | — | Training sandbox |
| [Load Balancer](azure/load-balancer.md) | VM-based load balancer | — | Training sandbox |
| [Storage + private endpoint](azure/storage-private-endpoint.md) | VM, storage, container, private endpoint | — | Training sandbox |
| [VNet, NSG, VPN gateway](azure/vnet-nsg-vpn-gateway.md) | VNet, NSG, and VPN gateway | — | Training sandbox |
| [Terraform VM + storage](azure/terraform-vm-storage.md) | Terraform-provisioned VM, storage, networking | Configuration files not retained | Training sandbox |

### AWS

| Entry | Covers | Files | Context |
|---|---|---|---|
| [EC2 + NGINX](aws/ec2-nginx.md) | EC2 provisioning, NGINX deployment, validation | — | Training sandbox |
| [Elastic Beanstalk](aws/elastic-beanstalk.md) | Docker/nginx on single-instance Elastic Beanstalk | — | Training sandbox |
| [Secrets Manager](aws/secrets-manager.md) | Secrets Manager deployment | — | Training sandbox |

### Linux

| Entry | Covers | Files | Context |
|---|---|---|---|
| [Ansible baseline](linux/ansible-baseline/) | Baseline configuration across Linux hosts | [`baseline.yml`](linux/ansible-baseline/baseline.yml) | Training sandbox |
| [Ansible daily ops](linux/ansible-daily-ops/) | Daily operations check | [`daily-ops.yml`](linux/ansible-daily-ops/daily-ops.yml) | Training sandbox |
| [Ansible health audit](linux/ansible-health-audit/) | Read-only health audit | [`health-audit.yml`](linux/ansible-health-audit/health-audit.yml) | Training sandbox |
| [Ansible NGINX deployment](linux/ansible-nginx-deployment/) | NGINX deployment and service check | [`deploy.yml`](linux/ansible-nginx-deployment/deploy.yml) | Training sandbox |

Shared: [`inventory.example.ini`](linux/inventory.example.ini) — example inventory for the playbooks above.

### Observability

| Entry | Covers | Files | Context |
|---|---|---|---|
| [Grafana + Prometheus on Docker](observability/grafana-prometheus-docker/) | Prometheus, Grafana, node_exporter, and cAdvisor monitoring stack | [`prometheus.example.yml`](observability/grafana-prometheus-docker/prometheus.example.yml), dashboard screenshots | Personal lab |

## Writing new entries

New entries follow [`RUNBOOK-TEMPLATE.md`](RUNBOOK-TEMPLATE.md).
[Elastic Beanstalk](aws/elastic-beanstalk.md) is the reference example.
Existing entries are converted to the template when they're next revised.

### Where things go

1. A top-level folder is an administrative boundary you log in to: a tenant, cloud account, OS fleet, or monitoring platform. It is created with its first real entry.
2. Tools and languages are properties, not places. Playbooks, scripts, and IaC live with the system they act on.
3. A parent folder is added only when two or more children share an administrative boundary.
4. An entry is a single file until it has companion files; then it becomes a folder with a `README.md` and those files.
5. A monitoring platform build goes in `observability/`. Dashboards and alerts for a specific system live with that system.
6. Work that someone else should run repeatedly, that needs tests or versioning, and that solves a named operational problem becomes its own repository. The entry here links to it.
7. Every entry states its context.
