VPC_NAME         = "dev-main-vpc"
SUBNET_NAME      = "dev-main-subnet"
REGION           = "us-central1"
CIDR_BLOCK       = "10.0.0.0/16"
GKE_CLUSTER_NAME = "dev-juice-shop-cluster"
MASTER_CIDR_BLOCK = "172.16.0.0/28"
MACHINE_TYPE      = "e2-medium"
NODE_POOL_NAME    = "dev-default-node-pool"
NODE_COUNT        = 3
NODE_MACHINE_TYPE = "e2-medium"
NODE_PREEMPTIBLE  = true
NAMESPACE         = "juice-shop-dev"
SSL_SECRET_NAME   = "dev-ssl-certificate"
NGINX_NAMESPACE   = "nginx-ingress-dev"
NGINX_CHART       = "bitnami/nginx-ingress-controller"
NGINX_REPOSITORY  = "https://charts.bitnami.com/bitnami"
NGINX_VERSION     = "9.6.1"
NGINX_VALUES_FILE = "helm/nginx-ingress-values-dev.yaml"
ZSCALER_POLICY_NAME        = "dev-zscaler-ip-policy"
ZSCALER_POLICY_DESCRIPTION = "Cloud Armor policy to restrict access to Zscaler IP addresses for dev"
ZSCALER_POLICY_RULES = [
  {
    action         = "allow"
    priority       = 1000
    versioned_expr = "SRC_IPS_V1"
    ip_ranges      = [
      "Zscaler_IP_Range_1",
      "Zscaler_IP_Range_2"
    ]
  },
  {
    action         = "deny(403)"
    priority       = 2000
    versioned_expr = "SRC_IPS_V1"
    ip_ranges      = ["0.0.0.0/0"]
  }
]
HEALTH_CHECK_NAME = "dev-nginx-health-check"
BACKEND_SERVICE_NAME  = "dev-nginx-backend-service"
BACKEND_PROTOCOL      = "HTTP"
LOAD_BALANCING_SCHEME = "EXTERNAL"
URL_MAP_NAME          = "dev-nginx-url-map"
PROXY_NAME            = "dev-http-proxy"
FORWARDING_RULE_NAME  = "dev-http-forwarding-rule"
FORWARDING_RULE_IP    = "<EXTERNAL_IP>"