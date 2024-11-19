This Terraform configuration provisions a Google Cloud external HTTP(S) load balancer, integrated with Cloud Armor security policies, to expose a JuiceShop application running on a Google Kubernetes Engine (GKE) cluster. The application is exposed via the NGINX Ingress Controller and protected by a Cloud Armor policy, limiting traffic to specific IP ranges, such as Zscaler IPs.

## Project Architecture

The Terraform project is organized as follows:
```
├── main.tf                    # Main Terraform configuration file
├── variables.tf               # Input variables file
├── outputs.tf                 # Output file to display relevant information
├── tfvars/                    # Directory for environment-specific tfvars files
│   └── dev.tfvars             # Development environment variable values
├── README.md                  # Documentation for the project
├── scripts/                   # Directory for utility scripts
│   └── generate_ssl_and_update_secret.py  # Script for SSL certificate generation
├── helm/                      # Directory for Kubernetes Helm values and manifests
│   ├── nginx-ingress-values.yaml          # Values file for NGINX Ingress Controller
│   └── juice-shop-deployment.yaml         # Kubernetes deployment manifest for JuiceShop
├── modules/                   # Directory for reusable Terraform modules
│   ├── vpc/                   # VPC module
│   │   ├── main.tf            # VPC resources and configuration
│   │   ├── outputs.tf         # Outputs for VPC module
│   │   └── variables.tf       # Variables for VPC module
│   ├── gke-cluster/           # GKE Cluster module
│   │   ├── main.tf            # GKE cluster resources and configuration
│   │   ├── outputs.tf         # Outputs for GKE cluster module
│   │   └── variables.tf       # Variables for GKE cluster module
│   ├── nodepool/              # Node pool module for GKE
│   │   ├── main.tf            # Node pool resources and configuration
│   │   ├── outputs.tf         # Outputs for node pool module
│   │   └── variables.tf       # Variables for node pool module
│   ├── nginx_ingress/         # NGINX Ingress module
│   │   ├── main.tf            # Resources for NGINX ingress
│   │   ├── outputs.tf         # Outputs for NGINX ingress module
│   │   └── variables.tf       # Variables for NGINX ingress module
│   ├── security_policy/       # Zscaler security policy module
│   │   ├── main.tf            # Security policy configuration
│   │   ├── outputs.tf         # Outputs for security policy module
│   │   └── variables.tf       # Variables for security policy module
│   ├── nginx_health_check/    # NGINX health check module
│   │   ├── main.tf            # Health check resources
│   │   ├── outputs.tf         # Outputs for health check module
│   │   └── variables.tf       # Variables for health check module
│   ├── nginx_backend_service/ # NGINX backend service module
│   │   ├── main.tf            # Backend service resources
│   │   ├── outputs.tf         # Outputs for backend service module
│   │   └── variables.tf       # Variables for backend service module
│   └── nginx_load_balancer/   # NGINX load balancer module
│       ├── main.tf            # Load balancer resources
│       ├── outputs.tf         # Outputs for load balancer module
│       └── variables.tf       # Variables for load balancer module
```

# GKE Infrastructure Setup with NGINX Load Balancer

This repository contains Terraform configuration files for provisioning a GKE (Google Kubernetes Engine) cluster along with NGINX Ingress, a security policy for Zscaler, and SSL certificate management. The following modules are used:

- **VPC**: For creating a Virtual Private Cloud and subnets.
- **GKE Cluster**: For creating a GKE cluster in Google Cloud.
- **Node Pool**: For configuring node pools within the GKE cluster.
- **NGINX Ingress**: For managing HTTP(S) ingress to the Kubernetes cluster.
- **Security Policy**: For configuring Zscaler security policies.
- **Load Balancer**: For creating a load balancer to manage traffic to the Kubernetes services.

## Prerequisites

- Terraform 1.x or higher
- Google Cloud Platform (GCP) account with appropriate permissions
- Google Cloud SDK (for managing GCP resources)
- Kubernetes CLI (`kubectl`)
- Python 3 (for SSL certificate generation)

## Overview of Resources

### 1. VPC Creation

This module sets up the Virtual Private Cloud (VPC) along with its subnets. It is used to isolate the network resources and enable secure communication between the GKE cluster and other resources.

- **VPC Name**: `var.VPC_NAME`
- **Subnet Name**: `var.SUBNET_NAME`
- **Region**: `var.REGION`
- **CIDR Block**: `var.CIDR_BLOCK`

### 2. GKE Cluster

This module creates a GKE cluster in the specified region. The cluster is configured with the given master CIDR block and machine type.

- **Cluster Name**: `var.GKE_CLUSTER_NAME`
- **Region**: `var.REGION`
- **Master CIDR Block**: `var.MASTER_CIDR_BLOCK`
- **Machine Type**: `var.MACHINE_TYPE`

### 3. Node Pool

The node pool module configures the node pool within the GKE cluster, specifying the number of nodes and machine type. It also supports preemptible nodes to optimize cost.

- **Node Pool Name**: `var.NODE_POOL_NAME`
- **Node Count**: `var.NODE_COUNT`
- **Machine Type**: `var.NODE_MACHINE_TYPE`
- **Preemptible**: `var.NODE_PREEMPTIBLE`

### 4. SSL Certificate Generation

A Python script is used to generate SSL certificates, which are then stored as Kubernetes secrets. The certificates are expected to be stored in the `certs/` directory.

- **Script Path**: `scripts/generate_ssl_and_update_secret.py`
- **Generated Secrets**: Stored in Kubernetes as `tls.crt` and `tls.key`.

### 5. NGINX Ingress Controller

The NGINX Ingress controller is deployed to manage external HTTP(S) traffic to services within the GKE cluster. The configuration includes specifying the chart, repository, version, and values file for Helm.

- **Namespace**: `var.NGINX_NAMESPACE`
- **Chart**: `var.NGINX_CHART`
- **Repository**: `var.NGINX_REPOSITORY`
- **Version**: `var.NGINX_VERSION`
- **Values File**: `var.NGINX_VALUES_FILE`

### 6. Zscaler Security Policy

This module creates a security policy with Zscaler that can be used to apply access control rules on the backend services, such as rate limiting or IP-based filtering.

- **Policy Name**: `var.ZSCALER_POLICY_NAME`
- **Policy Description**: `var.ZSCALER_POLICY_DESCRIPTION`
- **Policy Rules**: `var.ZSCALER_POLICY_RULES`

### 7. NGINX Backend Service

This module configures the NGINX backend service to handle traffic, including health checks, and attaches it to the GKE cluster.

- **Backend Service Name**: `var.BACKEND_SERVICE_NAME`
- **Protocol**: `var.BACKEND_PROTOCOL`
- **Health Check**: `module.nginx_health_check.health_check_id`
- **Security Policy**: `module.zscaler_security_policy.security_policy_self_link`

### 8. NGINX Load Balancer

The final module configures the NGINX load balancer, including URL mapping and proxy settings, along with the forwarding rule for directing traffic.

- **URL Map Name**: `var.URL_MAP_NAME`
- **Proxy Name**: `var.PROXY_NAME`
- **Forwarding Rule Name**: `var.FORWARDING_RULE_NAME`
- **IP Address**: `var.FORWARDING_RULE_IP`

## Variable Definitions

Ensure the following variables are defined in your `variables.tf` file:

```
variable "VPC_NAME" {}
variable "SUBNET_NAME" {}
variable "REGION" {}
variable "CIDR_BLOCK" {}
variable "GKE_CLUSTER_NAME" {}
variable "MASTER_CIDR_BLOCK" {}
variable "MACHINE_TYPE" {}
variable "NODE_POOL_NAME" {}
variable "NODE_COUNT" {}
variable "NODE_MACHINE_TYPE" {}
variable "NODE_PREEMPTIBLE" {}
variable "SSL_SECRET_NAME" {}
variable "NAMESPACE" {}
variable "NGINX_NAMESPACE" {}
variable "NGINX_CHART" {}
variable "NGINX_REPOSITORY" {}
variable "NGINX_VERSION" {}
variable "NGINX_VALUES_FILE" {}
variable "ZSCALER_POLICY_NAME" {}
variable "ZSCALER_POLICY_DESCRIPTION" {}
variable "ZSCALER_POLICY_RULES" {}
variable "BACKEND_SERVICE_NAME" {}
variable "BACKEND_PROTOCOL" {}
variable "LOAD_BALANCING_SCHEME" {}
variable "HEALTH_CHECK_NAME" {}
variable "URL_MAP_NAME" {}
variable "PROXY_NAME" {}
variable "FORWARDING_RULE_NAME" {}
variable "FORWARDING_RULE_IP" {}
```

**How to Deploy**

**Step 1: Initialize Terraform**
Navigate to the root directory of your Terraform project. Run the following command to initialize Terraform and download the necessary providers and modules:

terraform init

**Step 2: Set Up Google Cloud Credentials**
Ensure you have a Google Cloud service account credentials JSON file. Set the GOOGLE_CREDENTIALS environment variable to authenticate with Google Cloud:

export GOOGLE_CREDENTIALS=$(cat /path/to/your-service-account.json)
Alternatively, you can use gcloud auth application-default login for local testing.

**Step 3: Review the Deployment Configuration**
Review the dev.tfvars file located in the tfvars/ folder to ensure that all variables are configured appropriately for your environment.

**Step 4: Plan the Terraform Changes**
Run terraform plan to preview the infrastructure changes before applying them:

terraform plan -var-file=tfvars/dev.tfvars
This command helps ensure that all configurations are correct.

**Step 5: Apply the Terraform Configuration**
Deploy the infrastructure by applying the configuration:

terraform apply -var-file=tfvars/dev.tfvars
When prompted, type yes to confirm the changes.

**Step 6: Verify the Deployment**
After the terraform apply command completes, review the output displayed in the terminal (e.g., IP addresses, cluster names). Use these outputs to validate your deployment in Google Cloud or Kubernetes.

**Notes:**

To deploy in a different environment (e.g., staging or production), update or create a new variable file in the tfvars/ folder, such as staging.tfvars or prod.tfvars.
For such deployments, simply replace the variable file path in the following command:

terraform apply -var-file=tfvars/staging.tfvars

This process ensures that the deployment reflects the modular structure and environment-specific configurations. Verify that the application is accessible via the external IP configured in the forwarding rule. You can access the application at http://<EXTERNAL_IP>/ or https://<EXTERNAL_IP>/ if SSL is configured.

Use kubectl to verify the deployment in the Kubernetes cluster:

kubectl get pods
kubectl get svc

Cleaning Up
To destroy the infrastructure and clean up resources, run the following Terraform command:

terraform destroy -var-file=tfvars/dev.tfvars

**Additional Notes**
SSL/TLS Termination: SSL/TLS can be terminated at the NGINX Ingress Controller level by enabling HTTPS in the ingress section. Ensure the SSL certificate is correctly referenced in the tlsSecret field.
Scaling: You can scale the backend service by adjusting the number of replicas in the JuiceShop deployment.

**Conclusion**
This Terraform setup configures an external HTTP(S) load balancer with Cloud Armor security to expose a JuiceShop application on GKE. Traffic is routed through the NGINX Ingress Controller, with access restricted to the specified Zscaler IP ranges.


### Changes made:
- The **How to Deploy** section is added right after the **Variable Definitions** section to provide a clear guide on deploying the infrastructure using Terraform. 
- The instructions are broken down into steps, from initializing Terraform to applying the configuration and verifying the deployment, along with additional notes on SSL/TLS termination and scaling.

This should give a comprehensive guide for setting up and deploying the infrastructure..
