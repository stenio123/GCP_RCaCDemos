
# Demo - IaC CICD with Guardrails

## Overview
This demo has two main components - the GCP side and the Github side. **GCP** will be responsible for the CICD and guardrail automation, using CloudBuild and Cloudfunction, while **Github** will be responsible for storing the IaC and guardrail controls. 

For convenience, in this demo both the code to configure the CICD and the deployed infrastructure are in the same git repository. In real world settings, one would probably have two separate git repos. The IaC code is found in the "IaC" folder, and it is referred in cicd.tf. You can find examples of how to point to a remote cloudbuild.yaml [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#example-usage---cloudbuild-trigger-pubsub-config)


## Steps to deploy demo:
### Initial Configuration
- On Github, fork the repository to your account
- On Github, enable Cloud Build through Github Marketplace for the forked repo (or all)
- On GCP Cloud Build, click on "Triggers", select Github as "Source"
- Click "Authorize", enter password, select your account and forked repo
- On GCP console, git clone git repo
- Update variables.tf "iac_state_bucket_name" with valid name
- Update IaC/variables.tf with existing "project_id", and IaC/example_infrastructure.tf with same bucket name you use in "iac_state_bucket_name". You will need to commit and push to your forked/IaC repo

### IAM permissions
- On IAM, search for the Cloud Build Service Account, and add "Compute Engine Admin", "Network Admin" and "Object Storage Admin". Check notes for link documenting more refined permission control

### Deploy CICD pipeline
- Update CICDWithGuardrails/cicd.tf to point to your forked git repo 
- On GCP console, execute `terraform init; terraform apply`
- To trigger IaC build, make a change to a branch of IaC, push and merge to main.

### Destroying infrastructure
- To destroy IaC, comment all code, push and merge
- To destroy CICD pipeline, on GCP console execute `terraform destroy`
.

## Notes
- Cloud Build IAM permissions are controle through [Cloud Build Service Account](https://cloud.google.com/build/docs/securing-builds/configure-access-for-cloud-build-service-account?_ga=2.239260227.-1197172919.1670105530)
- Github is used as the source control in this demo, but any git repository supported by Cloud build should work

## Improvements needed
- Store state of CICD pipeline
- Pass IaC state bucket name as env var through CICD Cloud Build

## Troubleshooting

- Error "│ Error: Error creating Trigger: googleapi: Error 400: Repository mapping does not exist. Please visit https://console.cloud.google.com/cloud-build/triggers/connect?project=1005998595697 to connect a repository to your project"

You have not setup the connection between Github and Cloud Build. Check above instructions and follow steps.