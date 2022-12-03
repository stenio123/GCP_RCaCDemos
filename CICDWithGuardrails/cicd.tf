## This file describes the CICD and guardrail infrastructure
## Make sure you connect git repo to cloudbuild, per README.md

resource "google_cloudbuild_trigger" "include-build-logs-trigger" {
  location = "us-central1"
  filename = "CICDWithGuardrails/IaC/cloudbuild.yaml"
  name     = "include-build-logs-trigger"

  github {
    owner = "stenio123"
    name  = "GCP_RCaCDemos"
    push {
      branch = "^main$"
    }
  }

include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
  #service_account = google_service_account.cloudbuild_service_account.id

  

 /** depends_on = [
    google_project_iam_member.act_as,
    google_project_iam_member.logs_writer
  ]*/
}
/**resource "google_service_account" "cloudbuild_service_account" {
  account_id = "my-service-account"
}

resource "google_project_iam_member" "act_as" {
  project = data.google_project.project.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}

resource "google_project_iam_member" "logs_writer" {
  project = data.google_project.project.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}*/