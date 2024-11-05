module "datalake" {
  source = "./modules/datalake"
  project_name = var.project_name
}
module "warehouse" {
  source = "./modules/warehouse"
  project_name = var.project_name
}