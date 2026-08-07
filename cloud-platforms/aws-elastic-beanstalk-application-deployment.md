---
doc_type: build-record
capability: cloud-platforms
platform: aws
product: elastic-beanstalk
status: validated
environment: lab
last_validated: <YYYY-MM-DD>
tags:
  - aws
  - elastic-beanstalk
  - docker
  - nginx
  - paas
related: []
---

# AWS Elastic Beanstalk — Docker Application Deployment

## Summary

Provisioned an AWS Elastic Beanstalk environment to evaluate managed application deployment, platform abstraction, IAM role separation, and application lifecycle behavior.

A Docker-based nginx application was deployed to a single-instance web environment in `us-east-1`. The build also exposed an important platform requirement when an initial static HTML deployment failed because the selected Docker runtime required a valid container deployment artifact.

## Design Decisions

- **Docker platform** — selected to evaluate container-based application deployment through a managed PaaS rather than a framework-specific runtime.
- **Single-instance environment** — sufficient for validating deployment behavior without introducing load-balancing or auto-scaling complexity.
- **t3.micro instance** — appropriate for functional lab validation rather than performance or capacity testing.
- **Public subnet and public IP** — used to provide direct access to the application during validation.
- **Enhanced health reporting** — enabled to provide operational visibility into environment and instance health.
- **Managed platform updates** — enabled for minor and patch updates.
- **CloudWatch log streaming and X-Ray** — deferred for future observability enhancements.

<details>
<summary><strong>Configuration Reference</strong></summary>

| Setting | Configuration |
|---|---|
| Application | `nginx-demo-app` |
| Environment | `nginx-demo-env` |
| Region | `us-east-1` |
| Environment Tier | Web Server Environment |
| Platform | Docker |
| Platform Branch | Docker on 64-bit Amazon Linux 2023 |
| Platform Version | 4.12.1 |
| Environment Type | Single instance |
| Instance Type | `t3.micro` |
| Fleet Composition | On-Demand |
| Processor | x86_64 |
| Root Volume | gp3, 10 GB |
| VPC | Default lab VPC |
| Subnet | Single public subnet |
| Public IP | Enabled |
| Security Group | Default VPC security group |
| Service Role | `aws-elasticbeanstalk-service-role` |
| EC2 Instance Profile | `aws-elasticbeanstalk-ec2-role` |
| EC2 Key Pair | Not configured |
| Monitoring Interval | 5 minutes |
| Health Reporting | Enhanced |
| IMDSv1 | Disabled |
| Deployment Policy | All at once |
| Managed Platform Updates | Enabled |
| Update Level | Minor and patch |
| Proxy Server | nginx |
| CloudWatch Log Streaming | Disabled |
| X-Ray | Disabled |
| Database | Not enabled |

</details>

## Implementation

The initial deployment package contained only a static HTML file:

```bash
mkdir ~/beanstalk-v1

cat > index.html <<EOF
...
EOF

zip -r ../beanstalk-v1.zip .
ls -lh ~/beanstalk-v1.zip
```

After validating the Docker platform requirements, a corrected deployment package was created containing both a custom landing page and a valid Dockerfile:

```bash
mkdir ~/beanstalk-docker-v1

cat > index.html <<EOF
...
EOF

cat > Dockerfile <<EOF
...
EOF

zip -r ../beanstalk-docker-v1.zip .
ls -lh ~/beanstalk-docker-v1.zip
```

The corrected artifact was uploaded and deployed to the existing Elastic Beanstalk environment.

## Troubleshooting

### What Happened

The initial deployment contained only a static `index.html` file while the Elastic Beanstalk environment was configured for the Docker platform.

Although environment health remained **Ok**, the intended application version was not deployed. Environment events, deployment history, and CloudFormation status messages were reviewed to determine why the artifact had not been accepted.

### Root Cause

The selected Docker runtime requires a valid container deployment definition such as:

- `Dockerfile`
- `Dockerrun.aws.json`

A standalone HTML file did not satisfy the deployment contract for a Docker-based Elastic Beanstalk environment.

### Fix & Result

A new deployment package containing a valid `Dockerfile` and custom application content was created and redeployed.

The corrected version deployed successfully and became the active application version.

## Validation

Deployment success was confirmed through multiple independent checks:

- Environment health reached **Ok**
- Public Elastic Beanstalk URL was reachable
- Docker platform deployed successfully
- Environment events confirmed EC2 instance provisioning
- Deployment history confirmed successful application deployment
- IAM service role and EC2 instance profile provisioned correctly
- Custom nginx landing page rendered the expected content

## Lessons Learned

Managed platforms reduce infrastructure administration but do not eliminate platform-specific deployment requirements — this build's troubleshooting incident demonstrated that directly.

- Service roles and EC2 instance profiles perform different responsibilities and should be understood independently.

## Operational Notes & Roadmap

**Cleanup:** The environment was terminated after validation to prevent unnecessary AWS consumption. The CloudFormation stack entered `DELETE_IN_PROGRESS`, associated compute resources were removed, and no persistent workload was retained.

**Potential extensions:**

- GitHub-based CI/CD deployment
- CloudWatch log streaming
- HTTPS and custom domain configuration
- Multi-instance load balancing and Auto Scaling validation
