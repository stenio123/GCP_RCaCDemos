# Example Infrastructure Repository

## Overview
This is just an example of infrastructure code and associated security policies to be used in a CICD pipeline. The infrastructure and the policies can live in different git repositories, and the same Cloud Build can point to multiple git repositories.

## Execution
To test the policies locally (in GCloud console), without the CICD, run:

```
terraform init
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
wget -O opa https://openpolicyagent.org/downloads/v0.47.0/opa_linux_amd64_static
chmod 755 ./opa
./opa eval 'data.terraform.deny[x]' --data policies/ --input tfplan.json --format raw
```