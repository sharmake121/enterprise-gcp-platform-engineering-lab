# ☁️ Enterprise GCP Platform Engineering Lab

![Status](https://img.shields.io/badge/Status-In%20Progress-blue)
![Platform](https://img.shields.io/badge/Platform-Google%20Cloud-4285F4)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4)
![Kubernetes](https://img.shields.io/badge/Kubernetes-GKE-326CE5)
![GitOps](https://img.shields.io/badge/GitOps-FluxCD-success)
![License](https://img.shields.io/badge/License-MIT-green)

## 📖 Overview

The **Enterprise GCP Platform Engineering Lab** is a production-inspired cloud engineering project demonstrating how modern enterprise platforms can be designed, secured, automated, and operated on Google Cloud Platform (GCP).

Rather than focusing on isolated tutorials, this repository follows an end-to-end **Platform Engineering** approach inspired by real enterprise consulting and regulated-client environments.

The platform is built incrementally using:

* Infrastructure as Code
* Terraform
* Kubernetes
* GKE
* GitOps
* IAM
* Organization Policies
* VPC Service Controls
* Workload Identity
* Cross-cloud identity federation
* Observability
* Metadata-only monitoring

A key architectural principle is the separation of the **Azure control plane** from the **GCP client data plane**.

---

## 🎯 Project Goals

* Build an enterprise GCP resource hierarchy
* Design a secure GCP landing-zone foundation
* Implement Infrastructure as Code using Terraform
* Design least-privilege IAM architecture
* Implement Organization Policy security guardrails
* Implement VPC Service Controls
* Integrate Azure and GCP using Workload Identity Federation
* Deploy and secure Google Kubernetes Engine (GKE)
* Implement GKE Workload Identity
* Build GitOps deployment workflows using FluxCD
* Deploy enterprise monitoring with Grafana
* Integrate Grafana with Google Cloud Monitoring
* Implement metadata-only observability
* Demonstrate control-plane/data-plane separation
* Validate security controls through hands-on testing
* Document engineering decisions and architecture

---

## 🏗️ Architecture

```text
                         Azure Control Plane
                                │
                                │
                       OIDC / Federated Identity
                                │
                                ▼
                    Google Cloud Identity
                                │
                     Workload Identity
                       Federation / STS
                                │
                                ▼
                    ┌────────────────────┐
                    │  GCP Organization   │
                    │                    │
                    │ Resource Hierarchy │
                    └─────────┬──────────┘
                              │
                         Client Data
                            Plane
                              │
                              ▼
                         GCP Project
                              │
             ┌────────────────┼────────────────┐
             │                │                │
             ▼                ▼                ▼
        Organization      VPC Service        IAM
          Policies          Controls
             │
             ▼
            GKE
             │
      ┌──────┴────────┐
      │               │
      ▼               ▼
   Workloads       Monitoring
                      │
                      ▼
                   Grafana
                      │
                      ▼
              Google Cloud Monitoring
                      │
                      ▼
             Infrastructure Metadata
```

### Control Plane / Data Plane Model

```text
Azure Control Plane
        │
        │ Authorized Management
        ▼
GCP Client Data Plane
        │
        ├── GKE
        ├── Platform Services
        └── Client Workloads
                 │
                 └── Client Data
```

The architecture is designed so that platform management and operational observability do not require unrestricted access to client application data.

---

## ☁️ Technology Stack

| Category             | Technology                                       |
| -------------------- | ------------------------------------------------ |
| Cloud                | Google Cloud Platform                            |
| Secondary Cloud      | Microsoft Azure                                  |
| IaC                  | Terraform                                        |
| Containers           | Docker                                           |
| Orchestration        | Kubernetes / GKE                                 |
| GitOps               | FluxCD                                           |
| CI/CD                | GitHub Actions                                   |
| Monitoring           | Grafana + Google Cloud Monitoring                |
| Logging              | Google Cloud Logging                             |
| Identity             | IAM + Workload Identity                          |
| Cross-Cloud Identity | Workload Identity Federation                     |
| Security             | IAM, Organization Policies, VPC Service Controls |
| Version Control      | Git & GitHub                                     |
| Automation           | gcloud, kubectl, PowerShell                      |

---

## 📂 Repository Structure

```text
gcp-enterprise-platform-lab/
│
├── README.md
│
├── docs/
│   ├── architecture.md
│   ├── security.md
│   ├── identity-federation.md
│   ├── observability.md
│   └── validation.md
│
├── terraform/
│   ├── organization/
│   ├── iam/
│   ├── workload-identity/
│   ├── networking/
│   └── security/
│
├── kubernetes/
│   ├── monitoring/
│   ├── grafana/
│   └── flux/
│
└── diagrams/
    └── architecture.png
```

---

# 🛡️ Security

Security is implemented as multiple layers rather than relying on a single control.

### Security Layers

```text
Azure Identity
      │
      ▼
Workload Identity Federation
      │
      ▼
IAM / Least Privilege
      │
      ▼
Organization Policies
      │
      ▼
VPC Service Controls
      │
      ▼
GKE Workload Identity
      │
      ▼
Client Data Plane
```

### Organization Policies

The platform uses organization-level security controls including:

| Policy                                               | Purpose                                  |
| ---------------------------------------------------- | ---------------------------------------- |
| `iam.disableServiceAccountKeyCreation`               | Prevent long-lived service-account keys  |
| `iam.disableServiceAccountKeyUpload`                 | Prevent service-account key uploads      |
| `iam.automaticIamGrantsForDefaultServiceAccounts`    | Prevent automatic broad IAM grants       |
| `storage.uniformBucketLevelAccess`                   | Standardize Cloud Storage access control |
| `compute.restrictProtocolForwardingCreationForTypes` | Restrict protocol forwarding             |
| `compute.setNewProjectDefaultToZonalDNSOnly`         | Control default DNS configuration        |

### Security Validation

Service-account key creation was intentionally tested.

The operation was rejected:

```text
FAILED_PRECONDITION:
Key creation is not allowed on this service account.
```

This confirms that the organization-level security policy is actively enforced.

---

# 🔐 Cross-Cloud Identity

Azure is integrated with GCP using **Workload Identity Federation**.

```text
Azure Managed Identity
        │
        ▼
Azure OIDC Token
        │
        ▼
GCP Workload Identity Provider
        │
        ▼
Google Security Token Service
        │
        ▼
Short-Lived Google Credential
        │
        ▼
Authorized GCP Resource
```

### Benefits

* No long-lived GCP service-account keys
* Short-lived credentials
* Reduced credential-management overhead
* Centralized authorization
* Stronger control-plane/data-plane separation

---

# 🔑 GKE Workload Identity

Grafana uses a Kubernetes ServiceAccount mapped to a dedicated Google Cloud service account.

```text
Grafana Pod
    │
    ▼
Kubernetes ServiceAccount
    │
    ▼
GKE Workload Identity
    │
    ▼
Google Cloud Service Account
    │
    ▼
Short-Lived OAuth Token
    │
    ▼
Cloud Monitoring
```

The workload identity configuration was validated through the GKE metadata server.

The Grafana workload successfully received:

* Its expected Google Cloud identity
* An OAuth access token
* Successful access to the Google Cloud APIs required by the monitoring datasource

This eliminates the need for storing a static service-account JSON key inside the cluster.

---

# 🛡️ VPC Service Controls

The platform includes an **Access Context Manager security policy** for enterprise security boundaries.

VPC Service Controls provide an additional layer beyond IAM.

### IAM answers:

> Who is allowed to access the resource?

### VPC Service Controls help answer:

> From which security boundary should access be permitted?

Conceptually:

```text
              VPC SERVICE PERIMETER
        ┌──────────────────────────────┐
        │                              │
        │      Client Data Plane       │
        │                              │
        │      Protected Services      │
        │                              │
        └──────────────────────────────┘
                     │
              Security Boundary
                     │
               External Access
```

This provides defense in depth for sensitive client environments.

---

# 🚀 GitOps

The platform follows a declarative GitOps model using FluxCD.

```text
Git Repository
      │
      ▼
    FluxCD
      │
      ▼
 Kubernetes Resources
      │
      ▼
      GKE
```

GitOps provides:

* Version-controlled infrastructure
* Declarative configuration
* Automated reconciliation
* Configuration consistency
* Change history
* Reduced configuration drift
* Auditable deployments

The desired state is maintained in Git rather than relying on manual cluster configuration.

---

# ☸️ Kubernetes

Google Kubernetes Engine provides the application platform for the client data plane.

Current monitoring namespace:

```text
monitoring
```

The environment includes:

```text
GKE
 │
 └── monitoring
      │
      └── Grafana
           │
           └── Google Cloud Monitoring
```

Grafana is deployed using Kubernetes and operates using GKE Workload Identity.

---

# 📊 Monitoring

Grafana is integrated with **Google Cloud Monitoring** using the Google Cloud Monitoring datasource.

### Dashboard

```text
GKE Cluster Overview
```

### Current Panels

#### 1. GKE Node CPU

```text
kubernetes.io/node/cpu/allocatable_utilization
```

#### 2. GKE Node Memory

```text
kubernetes.io/node/memory/allocatable_utilization
```

#### 3. GKE Container CPU Usage

```text
kubernetes.io/container/cpu/core_usage_time
```

#### 4. GKE Container Memory Usage

```text
kubernetes.io/container/memory/used_bytes
```

#### 5. GKE Pod Count

```text
kubernetes.io/pod/uptime
```

#### 6. Container Restart Count

```text
kubernetes.io/container/restart_count
```

---

## 🔎 Metadata-Only Observability

A major design goal is to provide operational visibility without exposing client application data.

The monitoring layer focuses on infrastructure metadata:

* CPU utilization
* Memory utilization
* Pod counts
* Container resource usage
* Restart counts
* Infrastructure health

It does not require Grafana to access:

* Client application payloads
* Database records
* Business transactions
* Application secrets
* Authentication tokens
* Sensitive client records

This supports the separation between the platform management plane and client data plane.

---

# 📋 Validation

The platform has been validated through hands-on testing.

### GKE

```bash
kubectl get pods -n monitoring
```

Grafana is running successfully.

### Grafana Service

```bash
kubectl get svc -n monitoring
```

Grafana is deployed internally as a Kubernetes service.

### Workload Identity

```bash
kubectl get serviceaccount grafana -n monitoring -o yaml
```

The Kubernetes ServiceAccount is mapped to the dedicated Google Cloud service identity.

### Metadata Identity

The Grafana pod successfully queried the GKE metadata server and received its expected Google Cloud identity.

### Access Token

The metadata server successfully returned an OAuth access token.

### Grafana Health

Grafana health validation returned:

```text
database: ok
version: 12.3.0
```

### Organization Policy

A service-account key creation attempt was blocked by the organization policy.

### VPC Service Controls

The Access Context Manager security policy was successfully created and verified.

---

# 🧭 Resource Hierarchy

The project now demonstrates the GCP resource hierarchy concept:

```text
Organization
     │
     ├── Folders
     │
     └── Projects
            │
            └── Client Data Plane
```

The current lab client project is attached directly to the GCP Organization.

This is intentional for the current lab stage.

For a larger enterprise implementation, folders can be introduced to provide additional isolation:

```text
Organization
│
├── Platform
│   ├── Security
│   ├── Networking
│   └── Observability
│
└── Clients
    ├── Client A
    ├── Client B
    └── Client C
```

This structure allows centralized organization-level governance while maintaining clear client boundaries.

---

# 📅 Roadmap

### ✅ Completed

* GCP project foundation
* Resource hierarchy
* Terraform-based infrastructure
* IAM configuration
* Organization Policies
* Service-account key protection
* Azure → GCP identity federation
* Workload Identity Federation validation
* GKE deployment
* GKE Workload Identity
* VPC Service Controls
* FluxCD / GitOps
* Grafana deployment
* Google Cloud Monitoring integration
* GKE monitoring dashboard
* Metadata-only observability
* Security validation

### 🔄 Future Enhancements

* Production-grade folder hierarchy
* Dedicated shared-services project
* Centralized audit logging
* Security Information and Event Management integration
* Private GKE networking
* Cloud KMS integration
* Secret Manager integration
* Disaster Recovery architecture
* Automated security testing
* Policy-as-code validation
* CI/CD security gates
* Multi-client landing-zone automation

---

# 🎓 Skills Demonstrated

## Cloud Architecture

* Enterprise landing zones
* GCP resource hierarchy
* Hybrid cloud architecture
* Control-plane/data-plane separation

## Security

* IAM
* Least privilege
* Organization Policies
* VPC Service Controls
* Workload Identity
* Federated authentication
* Credential security

## Kubernetes

* GKE
* Kubernetes ServiceAccounts
* Workload Identity
* Kubernetes deployments
* Services
* ConfigMaps
* Secrets

## DevOps / Platform Engineering

* Terraform
* GitOps
* FluxCD
* GitHub Actions
* Declarative infrastructure
* Configuration management

## Observability

* Grafana
* Google Cloud Monitoring
* GKE metrics
* Infrastructure metadata
* Dashboard provisioning

## Cloud Automation

* `gcloud`
* `kubectl`
* PowerShell
* Terraform

---

# 📚 References

* Google Cloud Architecture Framework
* Google Cloud IAM documentation
* Google Cloud Organization Policy documentation
* Google Cloud VPC Service Controls documentation
* Google Cloud Workload Identity documentation
* Google Kubernetes Engine documentation
* Google Cloud Monitoring documentation
* Grafana documentation
* FluxCD documentation
* Terraform documentation

---

# 🏁 Final Architecture

The completed architecture can be summarized as:

```text
                     AZURE CONTROL PLANE
                              │
                              │
                     OIDC / Federation
                              │
                              ▼
                     GCP Identity Layer
                              │
                    Workload Identity
                              │
                              ▼
                    GCP ORGANIZATION
                              │
                    Organization Policies
                              │
                              ▼
                     CLIENT DATA PLANE
                              │
                   ┌──────────┴──────────┐
                   │                     │
                  GKE              VPC Service
                   │                 Controls
                   │
            Workload Identity
                   │
                   ▼
                Grafana
                   │
                   ▼
          Google Cloud Monitoring
                   │
                   ▼
          Infrastructure Metadata
```

The project demonstrates how an enterprise platform can combine **cloud governance, federated identity, Kubernetes, security boundaries, GitOps, and metadata-only observability** while maintaining a clear separation between platform management and client data.

---

# 👤 Author

**Sharmaake Dahir Ahmed**

Cloud / Platform Engineering

This repository is a hands-on enterprise cloud engineering lab and reference implementation focused on secure, automated, and observable cloud platforms.

---

## ⚠️ Disclaimer

This repository is a technical learning project and reference architecture.

Production deployments require additional organization-specific security, compliance, networking, resilience, monitoring, incident-response, and operational controls.
