
# Demo - IaC CICD with Guardrails

## Overview
This demo has two main components - the GCP side and the Github side. **GCP** will be responsible for the CICD and guardrail automation, using CloudBuild and Cloudfunction, while **Github** will be responsible for storing the IaC and guardrail controls. 

For convenience, in this demo both the code to configure the CICD and the deployed infrastructure are in the same git repository. In real world settings, one would probably have two separate git repos. The IaC code is found in the "IaC" folder, and it is referred in cicd.tf. You can find examples of how to point to a remote cloudbuild.yaml [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#example-usage---cloudbuild-trigger-pubsub-config)


## Steps to deploy demo:
### CICD

- Enable Cloud Build through Github Marketplace for desired git repos (or all)
- Connect Github repo to cloud build and authorize
- On GCP console, git clone git repo
- Update IaC/variables.tf with existing project id

### GitHub Configuration
- Install Cloud Build app in the repo
- Authorize
- Connect Github to Cloud Build https://cloud.google.com/architecture/managing-infrastructure-as-code#directly_connecting_cloud_build_to_your_github_repository'

### Deploy CICD pipeline
- On GCP console, execute `terraform init; terraform apply`
- To trigger IaC build, make a change to a branch of IaC, push and merge to main.

### Destroying infrastructure
- To destroy IaC, comment all code, push and merge
- To destroy CICD pipeline, on GCP console execute `terraform destroy`


## Notes
- Github is used as the source control in this demo, but any git repository supported by Cloud build should work
- In this demo, the terraform state file is stored as file in cloud console. In production the best practice is to store it in a Object Store bucket.