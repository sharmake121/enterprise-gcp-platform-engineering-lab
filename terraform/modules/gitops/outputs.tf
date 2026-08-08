output "gitops_service_account_email" {

  value = google_service_account.gitops_controller.email

}