output "cpu_alert_policy_name" {
  description = "High CPU alert policy name"

  value = google_monitoring_alert_policy.high_cpu.name
}