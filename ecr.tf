resource "aws_ecr_repository" "repositories" {
  for_each             = { for repo in var.ecr_repositories : repo.name => repo }
  name                 = "42gears/${each.value.name}"
  image_tag_mutability = each.value.tag_mutability

  image_scanning_configuration {
    scan_on_push = each.value.image_scan
  }

  tags = merge(
    var.tags,
    {
      Name = "42gears/${each.value.name}"
    }
  )
}

# ECR Repository Policies
resource "aws_ecr_repository_policy" "repository_policies" {
  for_each   = { for repo in var.ecr_repositories : repo.name => repo }
  repository = aws_ecr_repository.repositories[each.key].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowPull"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.eks_nodes.arn
        }
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
      }
    ]
  })
}

# Add ECR permissions to existing EKS node role
resource "aws_iam_role_policy" "eks_ecr_policy" {
  name = "${var.project_name}-${var.environment}-eks-ecr-policy"
  role = aws_iam_role.eks_nodes.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings"
        ]
        Resource = "*"
      }
    ]
  })
}