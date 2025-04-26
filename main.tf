module "network" {
  source               = "./modules/network"
  project_name         = "udemy-ecs"
  env                  = "dev"
  az_count             = 2
  public_subnet_count  = 2
  private_subnet_count = 2
  vpc_cidr             = "10.0.0.0/16"
  enable_nat_gateway   = false
}

module "security_groups" {
  source       = "./modules/security_groups"
  project_name = "example"
  env          = "dev"
  vpc_id       = module.network.vpc_id
}

module "alb" {
  source       = "./modules/loadbalancer"
  project_name = "example"
  env          = "dev"
  sg_ids       = module.security_groups.alb_sg_id
  subnet_ids   = module.network.public_subnet_ids
}
