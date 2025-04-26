variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "sg_ids" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}