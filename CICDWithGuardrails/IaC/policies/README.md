# Guardrail Policies

## Creating policies
1. Write rego policy, following the example *storage_bucket_private.rego*
2. Write terraform and generate tf plan output
```
terraform init
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
```
3. Write the tests, following the example *storage_bucket_private.test*.rego
4. Either adjust tfplan.json or copy the relevant parts to the mock file, following the *example storage_bucket.mock.json*
5. Download OPA and make it executable
```
wget -O opa https://openpolicyagent.org/downloads/v0.47.0/opa_linux_amd64_static
chmod 755 ./opa
```
6. Execute
```
./opa test . -v
```