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
}