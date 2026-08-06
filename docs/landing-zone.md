# Enterprise Landing Zone

## What is a Landing Zone?

## Why Organizations Need a Landing Zone

## Enterprise Design Principles

## Google Cloud Resource Hierarchy

## Folder Strategy
In an enterprise environment, folders are used to organize cloud resources based on business structure and environment separation.

This project adopts a three-environment strategy:

- Development: Used for feature development, experimentation, and early testing.
- Staging: Mirrors production and is used for validation before release.
- Production: Hosts live workloads and customer-facing services with the highest security controls.

This separation improves governance, IAM management, billing, security, and operational stability.
## Project Strategy
In an enterprise GCP environment, projects are used as security, billing, and operational boundaries.

This platform follows a multi-project strategy:

- Platform projects: Shared services such as networking, security, and logging.
- Development projects: Used for application development and testing.
- Staging projects: Used for validation before production deployment.
- Production projects: Host business-critical workloads with strict security controls.

Separate projects improve IAM management, cost visibility, security isolation, and governance.
## Security Guardrails

## IAM Strategy

## Next Steps