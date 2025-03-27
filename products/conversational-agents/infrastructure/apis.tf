# products/conversational-agents/infrastructure/apis.tf

locals {
  # Define the list of APIs needed for Conversational Agents and planned features
  # Find API identifiers: gcloud services list --available
  gcp_apis = [
    "dialogflow.googleapis.com",          # Core Conversational Agents API
    "dlp.googleapis.com",                 # Cloud Data Loss Prevention (for PII redaction)
    "logging.googleapis.com",             # Cloud Logging
    "monitoring.googleapis.com",          # Cloud Monitoring
    "cloudbuild.googleapis.com",          # Cloud Build (for backend deployment)
    "run.googleapis.com",                 # Cloud Run (for backend deployment)
    "iam.googleapis.com",                 # IAM (for service accounts/permissions)
    "discoveryengine.googleapis.com",     # Vertex AI Search/Discovery Engine (for RAG)
    "serviceusage.googleapis.com",        # Required to enable other APIs
    "artifactregistry.googleapis.com",    # Artifact Registry (if using Cloud Run/Build)
    # Add more as needed, e.g., BigQuery, Secret Manager, Pub/Sub
  ]
}

resource "google_project_service" "apis" {
  # Only enable APIs if the variable is set to true
  count   = var.enable_apis ? length(local.gcp_apis) : 0
  project = var.project_id
  service = local.gcp_apis[count.index]

  # Wait for the service usage API itself to be enabled before enabling others
  depends_on = [
    resource.google_project_service.service_usage_api,
  ]

  # Prevent accidental disabling of APIs if var.enable_apis is switched to false later
  disable_on_destroy = false
}

# Explicitly enable Service Usage API first as it's needed to enable others
resource "google_project_service" "service_usage_api" {
  count   = var.enable_apis ? 1 : 0
  project = var.project_id
  service = "serviceusage.googleapis.com"

  disable_on_destroy = false
}