resource "google_project_organization_policy" "disable_external_ips" {
  project    = var.project_id
  constraint = "compute.vmExternalIpAccess"

  list_policy {
    deny {
      all = true
    }
  }
}


resource "google_project_organization_policy" "require_os_login" {
  project    = var.project_id
  constraint = "compute.requireOsLogin"

  boolean_policy {
    enforced = true
  }
}


resource "google_project_organization_policy" "disable_sa_keys" {
  project    = var.project_id
  constraint = "iam.disableServiceAccountKeyCreation"

  boolean_policy {
    enforced = true
  }
}


resource "google_project_organization_policy" "storage_public_access_prevention" {
  project    = var.project_id
  constraint = "storage.publicAccessPrevention"

  boolean_policy {
    enforced = true
  }
}