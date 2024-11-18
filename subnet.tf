resource "aws_subnet" "private" {
  for_each = var.private_subnet_cidrs

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = merge(
    var.tags,
    {
      Name                              = "${var.project_name}-${var.environment}-private-${each.key}"
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/${var.project_name}-${var.environment}-eks" = "owned"
    }
  )
}

resource "aws_subnet" "public" {
  for_each = var.public_subnet_cidrs

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name                              = "${var.project_name}-${var.environment}-public-${each.key}"
      "kubernetes.io/role/elb"          = "1"
      "kubernetes.io/cluster/${var.project_name}-${var.environment}-eks" = "owned"
    }
  )
}
