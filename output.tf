output "repository_urls" {
  value = {
    for repo in var.ecr_repositories : 
    repo.name => aws_ecr_repository.repositories[repo.name].repository_url
  }
  description = "The URLs of the repositories"
}
