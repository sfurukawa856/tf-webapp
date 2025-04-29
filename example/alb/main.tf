module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project
  env          = var.env
  vpc_id       = module.network.vpc_id
}

module "alb" {
  source        = "../../modules/loadbalancer"  # モジュールの相対パス
  project_name  = var.project
  env           = var.env
  sg_ids        = module.security_groups.alb_sg_id # 仮のSG ID（実際の値に置き換えてください）
  subnet_ids    = data.aws_subnets.default.ids # 仮のSubnet ID
}