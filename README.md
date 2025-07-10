step 1: Fork and Clone the Repository
     Fork the GitHub repo to my own GitHub account.
     Clone it locally to work on the infrastructure and CI/CD setup.
     
step 2: Build Docker Image & Push to AWS ECR
    Set up a Dockerfile inside the app repository.
    Create an AWS ECR repository.
    Authenticate Docker to AWS.
    Build the Docker image and push it to ECR.
    
step 3: Create Terraform Files
         mkdir infra
         cd infra
         alb_ingress.tf
         ecr.tf
         cluster.tf
         iam.tf
         main.tf
         rds.tf
         s3.tf
         variables.tf
         vpc.tf
   Initialize and Apply
   #####################
      terraform init
      terraform plan
      terraform apply --auto-approve
     # var.db password: priya #

step 4: Setup IAM Role for S3 Integration
      Enable IAM OIDC provider on my EKS cluster.
      Create an IAM role for S3 access.
      Annotate my Kubernetes service account to use that IAM role.

step 4: Deploy to EKS 
     aws eks update-kubeconfig --region eu-north-1 --name rails-eks-cluster
   creating deployment, service and Ingress controller for one file
    deploy app to EKS

    Architecture Diagram
    ####################
                    ┌──────────────────────┐
                    │  Internet / Clients  │
                    └─────────┬────────────┘
                              │
                        ┌──── ▼─────┐
                        │   ALB     │  (Public Subnet)
                        └─────┬─────┘
                              │
                    ┌──────── ▼───────┐
                    │     EKS         │  (Private Subnet)
                    │  ┌───────────┐  │
                    │  │ Rails App │  │
                    │  └───────────┘  │
                    └──────┬──────────┘
                           │
              ┌────────────▼────────────┐
              │   Amazon RDS (Postgres) │
              └────────────┬────────────┘
                           │
               ┌───────────▼────────────┐
               │   Amazon S3 Bucket     │
               └────────────────────────┘
