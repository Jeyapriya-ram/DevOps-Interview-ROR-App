resource "aws_ecr_repository" "rails" {
  name                 = "rails-app"
  image_scanning_configuration { scan_on_push = true }
}

