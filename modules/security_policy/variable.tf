variable "policy_name" {
  description = "Name of the security policy"
  type        = string
}

variable "policy_description" {
  description = "Description of the security policy"
  type        = string
}

variable "policy_rules" {
  description = "List of rules for the security policy"
  type = list(object({
    action          = string
    priority        = number
    versioned_expr  = string
    ip_ranges       = list(string)
  }))
}
