# Guardrail Policies

## Creating policies
1. Write rego
2. Generate tf plan output
```
```
3. Create new file and copy output within mock hierarchy (use storage_bucket_private.mock.json as reference)
4. Create file to track tests and expected results

## Executing tests
To test:
```
curl -L -o opa https://openpolicyagent.org/downloads/v0.47.0/opa_linux_amd64_static
chmod 755 ./opa
./opa test . -v
```