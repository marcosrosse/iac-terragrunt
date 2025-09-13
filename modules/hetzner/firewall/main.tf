resource "hcloud_firewall" "generic_firewall" {
  name = var.firewall_name
  labels = var.labels

  dynamic "rule" {
    for_each = var.firewall_rules
    content {
      direction  = rule.value.direction
      protocol   = rule.value.protocol
      port       = rule.value.port
      source_ips = rule.value.source_ips
      description = lookup(rule.value, "description", null)
    }
  }
}
