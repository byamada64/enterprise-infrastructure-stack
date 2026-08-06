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
- **CloudWatch log streaming and X-Ray** — not enabled for this build and retained as future observability improvements.

Auto-scaling behavior was not exercised because the environment was intentionally deployed as a single instance.

## Environment Configuration

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

## Implementation

The initial application package contained a static HTML file:

```bash
mkdir ~/beanstalk-v1
cat > index.html <<EOF
...
EOF

zip -r ../beanstalk-v1.zip .
ls -lh ~/beanstalk-v1.zip
```

After validating the requirements of the selected Docker platform, a corrected Docker-based application package was created:

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

The corrected artifact was uploaded to Elastic Beanstalk and deployed to the existing environment.

Elastic Beanstalk handled the supporting infrastructure required for the environment, including EC2 provisioning and integration with the configured service role and instance profile.

## Troubleshooting

### Problem

The first deployment contained only a static `index.html` file while the Elastic Beanstalk environment was configured to use the Docker platform.

The environment itself remained healthy, but the intended application version was not deployed.

### Investigation

Environment events, deployment history, and CloudFormation status messages were reviewed to determine why the application artifact had not been accepted.

The health state alone was not sufficient evidence that the new application version had deployed because Elastic Beanstalk could return the environment to its last known-good state.

### Root Cause

A Docker-based Elastic Beanstalk environment requires a valid container deployment definition such as:

- `Dockerfile`
- `Dockerrun.aws.json`

A standalone static HTML file did not satisfy the deployment contract of the selected Docker platform.

### Resolution

A new deployment artifact was created containing:

- Custom `index.html`
- Valid `Dockerfile`

The corrected application package was uploaded and redeployed.

### Validation

After redeployment:

- Environment health returned to **Ok**
- Deployment history showed successful deployment
- Public environment URL remained reachable
- Custom nginx-hosted landing page rendered successfully

### Transferable Insight

Managed platforms reduce infrastructure administration, but they do not remove platform-specific application requirements.

Deployment artifacts must satisfy the contract of the selected runtime even when the underlying infrastructure is managed by the platform.

## Validation

The completed deployment was verified through multiple independent checks:

- Elastic Beanstalk environment reached **Ok** health
- Public Elastic Beanstalk domain was generated and reachable
- Docker platform on Amazon Linux 2023 launched successfully
- EC2 instance creation was confirmed through environment events
- Service role and EC2 instance profile were successfully provisioned
- Deployment history confirmed successful application deployment
- Health dashboard reported the instance as **Ok**
- Public application page loaded successfully
- Custom Docker-based landing page displayed the expected content

## Lessons Learned

Elastic Beanstalk abstracts much of the infrastructure required to host an application, but successful deployment still depends on understanding the selected runtime and its packaging requirements.

The build also reinforced several operational points:

- Environment health and deployment success are not always the same signal.
- Event history and CloudFormation status provide important evidence during failed deployments.
- Service roles and EC2 instance profiles perform different responsibilities and should be understood independently.
- Managed services reduce administrative effort without eliminating the need to understand the infrastructure and execution model underneath them.

## Operational Considerations

The environment was terminated after validation to prevent unnecessary AWS consumption.

Cleanup included:

- Terminating the Elastic Beanstalk environment
- Confirming the CloudFormation stack entered `DELETE_IN_PROGRESS`
- Releasing the public environment URL
- Removing associated compute resources through environment termination

No persistent production workload was retained after the lab.

## Future Improvements

Potential extensions to this build include:

- Deploy a second application version to validate repeatable release management
- Integrate GitHub-based CI/CD deployment
- Enable CloudWatch log streaming
- Add environment variables and application configuration
- Configure HTTPS and custom domain mapping
- Test multi-instance and load-balanced environments
- Evaluate auto-scaling behavior
- Compare Elastic Beanstalk with EC2-based application hosting and Azure App Service
- Deploy a functional application workload beyond the lightweight nginx landing page
