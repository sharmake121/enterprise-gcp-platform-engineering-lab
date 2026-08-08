resource "google_access_context_manager_access_policy" "enterprise" {

  parent = "organizations/${var.org_id}"

  title = var.policy_title
}