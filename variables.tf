variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name - will be used in all resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = map(string)
  default = {
    "ap-south-1a" = "10.0.0.0/19"
    "ap-south-1b" = "10.0.32.0/19"
  }
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = map(string)
  default = {
    "ap-south-1a" = "10.0.64.0/19"
    "ap-south-1b" = "10.0.96.0/19"
  }
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.28"
}

variable "node_groups" {
  description = "EKS node group configuration"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    desired_size   = number
    max_size       = number
    min_size       = number
    max_unavailable = number
    labels         = map(string)
    taints        = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
  default = {
    general = {
      instance_types  = ["t3.small"]
      capacity_type   = "ON_DEMAND"
      desired_size    = 1
      max_size        = 5
      min_size        = 0
      max_unavailable = 1
      labels = {
        role = "general"
      }
      taints = []
    }
  }
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}


variable "ecr_repositories" {
  description = "List of ECR repository names to create"
  type = list(object({
    name           = string
    image_scan     = bool
    tag_mutability = string
  }))
}