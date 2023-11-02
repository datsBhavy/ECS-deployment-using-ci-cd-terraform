resource "aws_codepipeline" "pipeline" {
  name     = "pipeline"
  role_arn = data.aws_iam_role.pipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.bucket-artifact.bucket
    type     = "S3"
  }
  # SOURCE
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "Github"
      version          = "2"
      output_artifacts = ["sourceArtifact"]

      configuration = {
        RepositoryName = "${var.repo_name}"
        BranchName     = "${var.branch_name}"
      }
    }
  }

  # BUILD
  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "Github"
      version          = "2"
      input_artifacts  = ["sourceArtifact"]
      output_artifacts = ["buildArtifact"]

      configuration = {
        ProjectName = "${var.build_project}"
      }
    }
  }

  # DEPLOY
  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["buildArtifact"]

      configuration = {
        ClusterName = "clusterDev"
        ServiceName = "node-Service"
        FileName    = "imagedefinitions.json"
      }
    }
  }
}