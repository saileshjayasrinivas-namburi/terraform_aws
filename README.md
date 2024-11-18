
# Terraform Infrastructure Setup

This repository contains Terraform configurations for deploying an AWS-based infrastructure, including an Elastic Kubernetes Service (EKS) cluster, networking components, and auxiliary services like Elastic Container Registry (ECR).

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) installed (v1.x or higher).
- AWS CLI configured with appropriate credentials.
- Sufficient IAM permissions to create and manage AWS resources (EKS, VPC, IAM roles, etc.).

## Directory Structure

- **`backend.tf`**: Configures the Terraform backend for remote state management.
- **`variables.tf`**: Defines input variables for the Terraform configuration.
- **`terraform.tfvars`**: Contains default values for variables. Update this file to customize your deployment.
- **`provider.tf`**: Specifies the AWS provider configuration.
- **`vpc.tf`**: Creates a Virtual Private Cloud (VPC) with subnets, route tables, and gateways.
- **`eks.tf`**: Provisions the EKS cluster and its associated IAM roles and policies.
- **`nodes.tf`**: Configures worker nodes for the EKS cluster.
- **`ecr.tf`**: Sets up AWS Elastic Container Registry (ECR) repositories.
- **`cluster_autoscaler.tf`**: Configures Kubernetes Cluster Autoscaler for scaling worker nodes.
- **`output.tf`**: Outputs useful information, such as EKS cluster endpoint and VPC details.

## How to Use

### 1. Initialize Terraform

Run the following command to initialize the project and download required providers and modules:

```bash
terraform init
```

### 2. Review and Update Variables

The default variables are defined in `variables.tf`. To customize these values, edit the `terraform.tfvars` file. For example:

```hcl
region = "us-west-2"
cluster_name = "my-eks-cluster"
node_instance_type = "t3.medium"
desired_capacity = 2
max_size = 5
min_size = 1
```

### Key Variables

| Variable             | Description                                   | Default Value     |
|----------------------|-----------------------------------------------|-------------------|
| `region`             | AWS region to deploy the infrastructure      | `us-west-2`       |
| `cluster_name`       | Name of the EKS cluster                      | `my-eks-cluster`  |
| `node_instance_type` | EC2 instance type for worker nodes           | `t3.medium`       |
| `desired_capacity`   | Desired number of worker nodes               | `2`               |
| `max_size`           | Maximum number of worker nodes               | `5`               |
| `min_size`           | Minimum number of worker nodes               | `1`               |

### 3. Apply the Configuration

Run the following command to create the resources:

```bash
terraform apply
```

You will be prompted to confirm the plan before Terraform provisions the infrastructure.

### 4. Access EKS Cluster

After the deployment is complete, configure your Kubernetes client to interact with the EKS cluster:

```bash
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

Replace `<region>` and `<cluster_name>` with your actual AWS region and cluster name.

### 5. Destroy the Infrastructure

To remove all resources created by Terraform, run:

```bash
terraform destroy
```

## Outputs

After applying the configuration, Terraform will output the following information:

- **EKS Cluster Endpoint**
- **VPC ID**
- **Subnets**

## Notes

- Ensure your AWS credentials have sufficient permissions to create the required resources.
- For production environments, consider using remote state backends like S3 with state locking enabled.

---

