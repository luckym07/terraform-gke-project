resource "google_compute_security_policy" "security_policy" {
  name        = var.policy_name
  description = var.policy_description

  dynamic "rule" {
    for_each = var.policy_rules
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        versioned_expr = rule.value.versioned_expr
        config {
          ip_ranges = rule.value.ip_ranges
        }
      }
    }
  }
}
