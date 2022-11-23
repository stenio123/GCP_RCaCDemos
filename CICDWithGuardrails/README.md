1. Specify project where resources governed by compliance controls will exist
2. Within this project, specify the network
3. (Optional) Provide a name for the Object Storage bucket that will store terraform state

Storing cloudbuild.yaml on the repo, to allow CICD pipeline to run multiple configurations.


## CICD
- trigger build using service account - needs to have sufficient permission to create resources
You need to have the Cloud Build Editor (roles/cloudbuild.builds.editor) role in your project to create triggers.

https://github.com/marketplace/google-cloud-build

Steps:
- Enable Cloud Build through Github Marketplace for desired git repos (or all)
- Connect Github repo to cloud build and authorize
- Execute terraform


### GitHub Configuration
- Fork or clone repo
- Install Cloud Build app in the repo
- Authorize?
- Connect Github to Cloud Build https://cloud.google.com/architecture/managing-infrastructure-as-code#directly_connecting_cloud_build_to_your_github_repository