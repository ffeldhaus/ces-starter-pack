# products/conversational-agents/infrastructure/outputs.tf

output "agent_id" {
  description = "The full ID of the deployed Conversational Agent."
  # Value will be assigned from the google_dialogflow_cx_agent resource later
  value = google_dialogflow_cx_agent.cymbal_retail_agent.id # Placeholder, resource not yet defined
  sensitive = false # Agent ID is generally not sensitive
}

output "agent_start_flow_id" {
  description = "The ID of the agent's default start flow."
  value       = google_dialogflow_cx_agent.cymbal_retail_agent.start_flow # Placeholder
}

# Add more outputs later: phone number, backend URL, etc.