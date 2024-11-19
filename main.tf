module "vpc" {
  source      = "./modules/vpc"
  vpc_name    = var.VPC_NAME
  subnet_name = var.SUBNET_NAME
  region      = var.REGION
  cidr_block  = var.CIDR_BLOCK
}

module "gke_cluster" {
  source            = "./modules/gke-cluster"
  cluster_name      = var.GKE_CLUSTER_NAME
  region            = var.REGION
  network_id        = module.vpc.vpc_id
  subnet_id         = module.vpc.subnet_id
  master_cidr_block = var.MASTER_CIDR_BLOCK
  machine_type      = var.MACHINE_TYPE
}

module "nodepool" {
  source         = "./modules/nodepool"
  node_pool_name = var.NODE_POOL_NAME
  cluster_name   = module.gke_cluster.gke_cluster_name
  region         = var.REGION
  node_count     = var.NODE_COUNT
  machine_type   = var.NODE_MACHINE_TYPE
  preemptible    = var.NODE_PREEMPTIBLE
}

resource "null_resource" "generate_ssl_cert" {
  provisioner "local-exec" {
    command     = "python3 ${path.module}/scripts/generate_ssl_and_update_secret.py"
    working_dir = "${path.module}/scripts"
  }

  depends_on = [module.gke_cluster]
}

resource "kubernetes_secret" "ssl_cert" {
  metadata {
    name      = var.SSL_SECRET_NAME
    namespace = var.NAMESPACE
  }

  data = {
    "tls.crt" = filebase64("${path.module}/certs/tls.crt")
    "tls.key" = filebase64("${path.module}/certs/tls.key")
  }

  depends_on = [null_resource.generate_ssl_cert]
}

module "nginx_ingress" {
  source       = "./modules/nginx_ingress"
  namespace    = var.NGINX_NAMESPACE
  chart        = var.NGINX_CHART
  repository   = var.NGINX_REPOSITORY
  version      = var.NGINX_VERSION
  values_file  = "${path.module}/${var.NGINX_VALUES_FILE}"
}

module "zscaler_security_policy" {
  source             = "./modules/security_policy"
  policy_name        = var.ZSCALER_POLICY_NAME
  policy_description = var.ZSCALER_POLICY_DESCRIPTION
  policy_rules       = var.ZSCALER_POLICY_RULES
}

module "nginx_health_check" {
  source            = "./modules/nginx_health_check"
  health_check_name = var.HEALTH_CHECK_NAME
}

module "nginx_backend_service" {
  source                 = "./modules/nginx_backend_service"
  backend_service_name   = var.BACKEND_SERVICE_NAME
  protocol               = var.BACKEND_PROTOCOL
  load_balancing_scheme  = var.LOAD_BALANCING_SCHEME
  health_checks          = [module.nginx_health_check.health_check_id]
  backend_group          = module.gke_cluster.gke_cluster_name
  security_policy_self_link = module.zscaler_security_policy.security_policy_self_link
}

module "nginx_load_balancer" {
  source               = "./modules/nginx_load_balancer"
  url_map_name         = var.URL_MAP_NAME
  default_service      = module.nginx_backend_service.backend_service_self_link
  proxy_name           = var.PROXY_NAME
  forwarding_rule_name = var.FORWARDING_RULE_NAME
  ip_address           = var.FORWARDING_RULE_IP
}
