
# Demo - IaC CICD with Guardrails

![CICDDemo](CICDDemo.png)

## Overview
This demo has two main components - the GCP side and the Github side. **GCP** will be responsible for the CICD and guardrail automation, using CloudBuild and Cloudfunction, while **Github** will be responsible for storing the IaC and guardrail controls.

The above diagram presents the proposed end state. For simplicity, in this demo all three git repositories presented - the code to configure the CICD, the deployed infrastructure, and the policies are in the same git repository. In real world settings, one would probably have three or more separate git repos. Multiple IaC repositories can be supported, each one with its own Cloud Build Trigger and associated service account. 

The IaC code is found in the "IaC" folder, and it is referred in cicd.tf. You can find examples of how to point to a remote github repo on cloudbuild.yaml [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#example-usage---cloudbuild-trigger-pubsub-config)


## Steps to deploy demo:
### Initial Configuration
- On Github, fork the repository to your account
- On Github, enable Cloud Build through Github Marketplace for the forked repo (or all)
- On GCP Cloud Build, click on "Triggers", select Github as "Source"
- Click "Authorize", enter password, select your account and forked repo
- On GCP console, git clone git repo
- Update variables.tf "iac_state_bucket_name" with valid name
- Update IaC/variables.tf with existing "project_id", and IaC/example_infrastructure.tf with same bucket name you use in "iac_state_bucket_name". 
- Update cicd.tf with your github repo information
- You will need to commit and push to your forked/IaC repo

### IAM permissions
- On IAM, search for the Cloud Build Service Account, and add "Compute Engine Admin", "Network Admin" and "Object Storage Admin". Check notes for link documenting more refined permission control

### Deploy CICD pipeline
- Update CICDWithGuardrails/cicd.tf to point to your forked git repo 
- On GCP console, execute `terraform init; terraform apply`
- To trigger IaC build, make a change to a branch of IaC, push to git (and merge if not main branch)
- For example, remove comments to deploy, add comments to destroy

### Destroying infrastructure
- To destroy IaC, comment all code, push (and merge if not main branch)
- To destroy CICD pipeline, on GCP console execute `terraform destroy`

## Notes
- Cloud Build IAM permissions are controled through [Cloud Build Service Account](https://cloud.google.com/build/docs/securing-builds/configure-access-for-cloud-build-service-account?_ga=2.239260227.-1197172919.1670105530)
- Github is used as the source control in this demo, but any git repository supported by Cloud build should work

### Creating and testing new policies
Check the [IaC/policies](IaC/policies) folder

## TODO
- Example of cloudbuild jobs with different service accounts and limited permissions
- IaC/cloudbuild.yaml uses terraform apply on the tfplan file
- Store state of CICD pipeline
- Pass IaC state bucket name as env var through CICD Cloud Build
- Documentation on pointing to branches other than main (PR, review, merge)

## Troubleshooting

- Error "??? Error: Error creating Trigger: googleapi: Error 400: Repository mapping does not exist. Please visit https://console.cloud.google.com/cloud-build/triggers/connect?project=1005998595697 to connect a repository to your project"

You have not setup the connection between Github and Cloud Build. Check above instructions and follow steps.