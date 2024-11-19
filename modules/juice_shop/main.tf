module "juice_shop_deployment" {
  source    = "../kubernetes_manifest"
  manifests = {
    juice_shop_deployment = { file_path = "${path.module}/helm/juice-shop-deployment.yaml" }
    juice_shop_service    = { file_path = "${path.module}/helm/juice-shop-service.yaml" }
  }
}
