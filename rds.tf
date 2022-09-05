module "aurora_mysql_serverlessv2" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.3.0"

  name                   = "${local.name}-aurora-db-main"
  engine                 = "aurora-mysql"
  engine_mode            = "provisioned"
  engine_version         = "8.0.mysql_aurora.3.02.0"
  storage_encrypted      = true
  tags                   = local.tags
  database_name          = local.database_name
  create_random_password = false
  master_password        = var.master_password

  vpc_id                = data.aws_vpc.default.id
  subnets               = data.aws_subnets.default.ids
  create_security_group = true


  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.main.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.main.id

  deletion_protection = false

  serverlessv2_scaling_configuration = {
    auto_pause               = true
    min_capacity             = 0.5
    max_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  instance_class = "db.serverless"
  instances = {
    one = {
      publicly_accessible = true
    }
  }
}

resource "aws_db_parameter_group" "main" {
  name        = "${local.name}-aurora-db-parameter-group"
  family      = "aurora-mysql8.0"
  description = "${local.name}-aurora-db-parameter-group"
  tags        = local.tags
}

resource "aws_rds_cluster_parameter_group" "main" {
  name        = "${local.name}-aurora-db-cluster-parameter-group"
  family      = "aurora-mysql8.0"
  description = "${local.name}-aurora-db-cluster-parameter-group"
  tags        = local.tags
}
