resource "google_monitoring_alert_policy" "high_cpu" {
  project = var.project_id

  display_name = "High CPU Utilization Alert"

  combiner = "OR"

  conditions {
    display_name = "VM CPU usage above 80%"

    condition_threshold {

      filter = "resource.type=\"gce_instance\" AND metric.type=\"compute.googleapis.com/instance/cpu/utilization\""

      comparison = "COMPARISON_GT"

      threshold_value = 0.8

      duration = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  documentation {
    content = "Alert when Compute Engine VM CPU utilization exceeds 80% for 5 minutes."
  }

  enabled = true
}