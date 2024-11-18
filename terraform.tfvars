project_name = "sailesh"
environment  = "dev"
region       = "ap-south-1"

private_subnet_cidrs = {
  "ap-south-1a" = "10.0.1.0/24"   
  "ap-south-1b" = "10.0.2.0/24"   
}

public_subnet_cidrs = {
  "ap-south-1a" = "10.0.3.0/24"   
  "ap-south-1b" = "10.0.4.0/24"   
}

tags = {
  Environment = "dev"
  Project     = "my-project"
  Terraform   = "true"
  Owner       = "devops-team"
}

node_groups = {
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
#   app-nodes = {
#     instance_types  = ["t3.large"]
#     capacity_type   = "ON_DEMAND"
#     desired_size    = 2
#     max_size        = 4
#     min_size        = 1
#     max_unavailable = 1
#     labels = {
#       role = "application"
#       app-type = "backend"
#     }
#     taints = [
#       {
#         key    = "dedicated"
#         value  = "backend"
#         effect = "NoSchedule"
#       }
#     ]
#   }
}




ecr_repositories = [
  {
    name           = "browserapi"
    image_scan     = true
    tag_mutability = "MUTABLE"
  },
  {
    name           = "suremdm"
    image_scan     = true
    tag_mutability = "MUTABLE"
  }
]