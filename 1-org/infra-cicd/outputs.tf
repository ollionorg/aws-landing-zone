output "codepipeline_role_name" {
  value = module.setup_cicd_account[*].codepipeline_role_name
}

output "codebuild_role_name" {
  value = module.setup_cicd_account[*].codebuild_role_name
}