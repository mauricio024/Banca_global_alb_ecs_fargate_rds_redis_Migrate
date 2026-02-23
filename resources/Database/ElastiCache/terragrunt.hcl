include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../Network/VPC"
  mock_outputs = {
    database_subnets = ["subnet-12345678", "subnet-87654321"]
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  subnet_ids         = dependency.vpc.outputs.database_subnets
  create_elasticache = false  # Set to true to create ElastiCache resources
}
