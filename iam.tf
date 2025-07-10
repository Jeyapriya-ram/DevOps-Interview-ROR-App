# OIDC IAM trust policy for pod role
data "aws_iam_policy_document" "eks_pod_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [module.eks.oidc_provider_arn] # Correct OIDC provider ARN
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.oidc_provider, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:rails-app-sa"] # Adjust if using different namespace or SA
    }
  }
}

# IAM Role to attach to the pod
resource "aws_iam_role" "eks_pod_s3" {
  name               = "eks-pod-s3-role"
  assume_role_policy = data.aws_iam_policy_document.eks_pod_assume_role.json

  tags = {
    Name = "eks-pod-s3-role"
  }
}

# S3 access policy
resource "aws_iam_policy" "eks_s3" {
  name = "eks-pod-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${var.cluster_name}-assets",
          "arn:aws:s3:::${var.cluster_name}-assets/*"
        ]
      }
    ]
  })
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "pod_s3_attach" {
  role       = aws_iam_role.eks_pod_s3.name
  policy_arn = aws_iam_policy.eks_s3.arn
}

