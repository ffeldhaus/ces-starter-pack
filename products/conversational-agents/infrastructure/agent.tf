# products/conversational-agents/infrastructure/agent.tf

resource "google_dialogflow_cx_agent" "cymbal_retail_agent" {
  provider = google-beta # Often safer to use beta provider for latest features

  display_name         = var.agent_name
  location             = var.region # Agents are regional resources in Conversational Agents
  default_language_code = var.agent_language_code
  time_zone            = var.agent_time_zone
  project              = var.project_id

  # Enable Git Integration (Basic Setup)
  # Note: The actual connection might require a manual step in the GCP Console
  # after the repo is ready and Terraform has run.
  # We point Terraform to the expected repo details.
  git_integration_settings {
    github_settings {
      display_name      = "${var.agent_name} Git Repo"
      repository_uri    = var.git_repo_url
      tracking_branch   = var.git_branch
      # agent_directory: Path within the repo where the agent definition lives.
      # We'll structure our repo later to put it here:
      agent_directory = "industries/cymbal-retail/agent"
      # branches, access_token_secret_version are omitted for HTTPS connection initially
    }
  }

  # Placeholder for Advanced Settings (DLP, etc.) - will configure later
  # advanced_settings {
  #   audio_export_gcs_destination {
  #     uri = "gs://your-audio-export-bucket/prefix" # Example, requires a bucket
  #   }
  #   interaction_logging_settings {
  #      enable_interaction_logging = true
  #      enable_stackdriver_logging = true
  #   }
  # }

  # TODO: Configure Speech-to-Text settings if needed
  # speech_to_text_settings {
  #   enable_speech_adaptation = true
  # }

  # TODO: Add lifecycle management if needed (e.g., prevent_destroy)
}

# Output the agent details defined earlier in outputs.tf
# No new resources needed here, just ensuring the connection exists.