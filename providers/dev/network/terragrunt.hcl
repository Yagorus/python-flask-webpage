terraform {
  source = "../../../modules//network"
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

