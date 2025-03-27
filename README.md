# Google Cloud Customer Engagement Suite (CES) Starter Pack

This repository provides starter packs for demonstrating Google Cloud Customer Engagement Suite (CES) capabilities, including Conversational Agents, Agent Assist, and Insights.

## Current Focus

*   **Product:** Conversational Agents
*   **Industry:** Cymbal Retail (Mock Retailer)

## Prerequisites

*   GCP Account with Billing Enabled
*   `gcloud` CLI installed and authenticated (`gcloud auth application-default login`)
*   Terraform installed (`terraform version`)
*   `uv` installed (`uv --version`)
*   Git installed (`git --version`)
*   A Git repository (e.g., GitHub, GitLab, Cloud Source Repositories) - you can use your fork of this repo.

## Setup Instructions

1.  **Clone Repository:**
    ```bash
    git clone https://github.com/ffeldhaus/ces-starter-pack.git
    cd ces-starter-pack
    ```

2.  **Set Up Python Environment:**
    ```bash
    uv venv
    source .venv/bin/activate # or .venv\Scripts\activate on Windows
    # uv pip install ... # We will add dependencies later
    ```

3.  **Prepare Terraform Backend:**
    *   **Choose a GCS Bucket Name:** Select a globally unique name for your Terraform state bucket (e.g., `my-ces-starter-pack-tfstate-123`). Keep this name handy.
    *   **Create the GCS Bucket:** Use the `gcloud` CLI (or GCP Console) to create the bucket in your project. Replace `YOUR_BUCKET_NAME` and `YOUR_PROJECT_ID`. Enable versioning for safety.
        ```bash
        gcloud storage buckets create gs://YOUR_BUCKET_NAME --project=YOUR_PROJECT_ID --location=US # Or your preferred location
        gcloud storage buckets update gs://YOUR_BUCKET_NAME --versioning-enabled=true
        ```

4.  **Configure Terraform Variables:**
    *   Navigate to the infrastructure directory:
        ```bash
        cd products/conversational-agents/infrastructure
        ```
    *   Create a `terraform.tfvars` file by copying the example:
        ```bash
        cp terraform.tfvars.example terraform.tfvars
        ```
    *   **Edit `terraform.tfvars`:** Fill in the required values:
        *   `project_id`: Your GCP Project ID.
        *   `gcs_bucket_tf_state`: The `YOUR_BUCKET_NAME` you created above.
        *   `git_repo_url`: The HTTPS URL of *your* Git repository where the agent definition will reside (e.g., your fork of `ces-starter-pack` or another repo). Example: `"https://github.com/YOUR_USERNAME/ces-starter-pack.git"`.
        *   Adjust optional variables like `region`, `agent_name` if needed.

5.  **Initialize Terraform:**
    *   Run `terraform init` and provide the backend configuration using the `-backend-config` flag. This links Terraform to your GCS bucket.
        ```bash
        terraform init \
          -backend-config="bucket=YOUR_BUCKET_NAME" \
          -backend-config="prefix=ces-starter-pack/cymbal-retail/conversational-agents"
        ```
        *(Replace `YOUR_BUCKET_NAME` with your actual bucket name)*. The `prefix` organizes the state file within the bucket.

6.  **Deploy Infrastructure (Plan):**
    *   Run `terraform plan` to see the resources that will be created.
        ```bash
        terraform plan -out=tfplan
        ```
    *   Review the plan carefully.

7.  **Deploy Infrastructure (Apply):**
    *   If the plan looks correct, apply the changes:
        ```bash
        terraform apply tfplan
        ```
    *   Type `yes` when prompted. This will enable APIs and create the initial Conversational Agent resource pointing to your Git repo (though the agent content isn't there yet).

8.  **Agent Definition Setup:** *(Steps to be detailed later)*
    *   Create agent files locally.
    *   Push agent files to your Git repository.
    *   Manually link Git repo in GCP Console (if Terraform setup isn't sufficient).
    *   Trigger sync.

9.  **Website Integration:** *(Steps to be detailed later)*

10. **Test:** *(Steps to be detailed later)*

*   Navigate back to the project root when finished with Terraform:
    ```bash
    cd ../../..
    ```

## Structure

*   `industries/`: Industry-specific configurations and customizations.
    *   `cymbal-retail/`: Current focus.
*   `products/`: Core implementation for CES products.
    *   `conversational-agents/`: Conversational Agents specific components (Terraform, Agent definition structure, Backend, Website).
*   `shared/`: Reusable Terraform modules, libraries, etc.

*(This starter pack is under construction)*