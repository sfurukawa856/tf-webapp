module "security_groups" {
  source       = "../../modules/security_groups"
  project_name = var.project
  env          = var.env
  vpc_id       = data.aws_vpc.default.id
}

module "alb" {
  source        = "../../modules/loadbalancer"
  project_name  = var.project
  env           = var.env
  sg_ids        = module.security_groups.alb_sg_id
  subnet_ids    = data.aws_subnets.default.ids
}