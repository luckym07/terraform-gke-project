output "juice_shop_deployment_name" {
  value = module.juice_shop_deployment.juice_shop_deployment_name
}

output "juice_shop_deployment_replicas" {
  value = module.juice_shop_deployment.juice_shop_deployment_replicas
}

output "juice_shop_service_name" {
  value = module.juice_shop_deployment.juice_shop_service_name
}

output "juice_shop_service_cluster_ip" {
  value = module.juice_shop_deployment.juice_shop_service_cluster_ip
}

output "juice_shop_service_port" {
  value = module.juice_shop_deployment.juice_shop_service_port
}