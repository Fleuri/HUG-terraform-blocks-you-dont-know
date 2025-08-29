store "varset" "tokens" {
  id = "varset-RhxhHwHRB1eFuW3t" # Replace with the identifier of your varset.
  category = "terraform"
}

deployment production {
  inputs = {
    deployment_name = "prod"
    regions = ["europe-north1", "europe-west1", "europe-west2"]
    gcp-creds = store.varset.tokens.gcp-creds
    deploy_gcs = ["true"]
  }
}

deployment staging {
  inputs = {
    deployment_name = "staging"
    regions    = ["europe-north1", "europe-west1"]
    gcp-creds = store.varset.tokens.gcp-creds
    deploy_gcs = []
  }
}

orchestrate "auto_approve" "automatically_apply_staging_changes" {
    check {
        condition = context.plan.deployment == deployment.staging
        reason = "Only apply staging changes."
    }

    check {
        condition = context.plan.applyable == true
        reason = "Auto approve only applyable plans."
    }
}
