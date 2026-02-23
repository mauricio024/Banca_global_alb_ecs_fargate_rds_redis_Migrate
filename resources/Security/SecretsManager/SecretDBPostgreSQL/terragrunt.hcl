include "root"  {
  path = find_in_parent_folders()
}

dependency "rds" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/Database/RDS/Postgresql_Main"
  mock_outputs = {
    db_instance_address     = "postgresdb.c9nhww44flaz.us-east-1.rds.amazonaws.com"
    db_instance_endpoint    = "postgresdb.c9nhww44flaz.us-east-1.rds.amazonaws.com:5432"
    db_instance_username    = "sensitive"
    db_instance_password    = "sensitive"
    db_instance_port        = 5432
    db_instance_name        = "postgresdb"
    db_engine               = "postgres"
    db_instance_resource_id = "db-QLZ5MDXWIWNLUR4TVDRFH5Y3PU"
    db_instance_id          = "postgresdb"

  }
  skip_outputs = false
}

inputs = {
  db_instance_port        = dependency.rds.outputs.db_instance_port
  db_instance_username    = dependency.rds.outputs.db_instance_username
  db_instance_password    = dependency.rds.outputs.db_instance_password
  db_instance_endpoint    = dependency.rds.outputs.db_instance_endpoint
  db_instance_name        = dependency.rds.outputs.db_instance_name
  db_instance_address     = dependency.rds.outputs.db_instance_address
  db_engine               = dependency.rds.outputs.db_engine
  db_instance_id          = dependency.rds.outputs.db_instance_id
  db_instance_resource_id = dependency.rds.outputs.db_instance_resource_id
}