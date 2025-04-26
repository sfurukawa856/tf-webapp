resource "aws_lb" "this" {
  name               = "${var.project_name}-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_ids]
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}