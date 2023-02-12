terraform {
  source = "../../../modules//cluster"
}

include {
  path = find_in_parent_folders()
}

dependency "ecr" {
    config_path = "../ecr"
    mock_outputs = {
      ecr_repository_url = "000000000000.dkr.ecr.eu-west-1.amazonaws.com/image"
  }
}

dependency "initbuild" {
    config_path = "../initbuild"
    skip_outputs = true
}

dependency "network" {
    config_path = "../network"
    mock_outputs = {
      aws_lb_target_group_arn = "arn:aws:elasticloadbalancing:eu-central-1:264716044050:targetgroup/ecs-flaska-flask-app-service/cb9ea27e466ec8bb"
      public_subnets = ["subnet-09a4eebc2c8bd80b2", "subnet-06a166845821cdda2"]
      security_group_id = "sg-0c7e26e48066dec1f"
      service_security_group = "sg-0c7226e48066dec1f"
    }
}

inputs = {
    ecr_repository_url = dependency.ecr.outputs.ecr_repository_url
    aws_lb_target_group_arn = dependency.network.outputs.aws_lb_target_group_arn
    security_group_id = dependency.network.outputs.security_group_id
    public_subnets = dependency.network.outputs.public_subnets
    service_security_group = dependency.network.outputs.service_security_group
}