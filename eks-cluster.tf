module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.11.0"  # Use latest stable version

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = aws_vpc.main.id
  subnet_ids      = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Environment = "dev"
    Project     = "rails-app"
  }
}

