# products/conversational-agents/infrastructure/variables.tf

variable "project_id" {
  type        = string
  description = "The Google Cloud project ID where resources will be deployed."
}

variable "region" {
  type        = string
  description = "The Google Cloud region for deployment (e.g., 'us-central1')."
  default     = "us-central1"
}

variable "agent_name" {
  type        = string
  description = "The display name for the Conversational Agent."
  default     = "Cymbal Retail Agent" # Defaulting to Cymbal Retail for now
}

variable "agent_language_code" {
  type        = string
  description = "The default language code for the agent (e.g., 'en')."
  default     = "en"
}

variable "agent_time_zone" {
  type        = string
  description = "The time zone for the agent (e.g., 'America/Los_Angeles')."
  # Find appropriate time zones: https://cloud.google.com/dialogflow/cx/docs/reference/rest/v3/projects.locations.agents#timezonestr
  default     = "America/New_York"
}

variable "gcs_bucket_tf_state" {
  type        = string
  description = "The name of the GCS bucket used to store Terraform state. This bucket must be created manually beforehand."
  # Example: "my-unique-tf-state-bucket"
}

variable "git_repo_url" {
  type        = string
  description = "The HTTPS URL of the Git repository containing the agent definition (for Git Integration). Example: https://github.com/user/repo.git"
  default     = "" # User must provide this
}

variable "git_branch" {
  type        = string
  description = "The branch in the Git repository to sync the agent from."
  default     = "main"
}

variable "enable_apis" {
  type        = bool
  description = "Whether to enable necessary GCP APIs via Terraform."
  default     = true
}

# Add more variables later for DLP, Phone Gateway, Connectors, RAG etc.