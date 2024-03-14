output "codepipeline_name" {
  description = "The name of the pipeline."
  value       = module.setup_cicd_account.codepipeline_name
}

output "codebuild_name" {
  description = "Codebuild Project's name"
  value       = module.setup_cicd_account.codebuild_name
}

output "codepipeline_s3bucket" {
  description = "Name of the Codepipeline bucket"
  value       = module.setup_cicd_account.codepipeline_s3_bucket
}

output "codebuild_s3bucket" {
  description = "Name of the  Codebuild bucket"
  value       = module.setup_cicd_account.codebuild_s3_bucket
}