package templates.gcp.GCPComputeShieldedVMConstraintV1

import data.test.fixtures.compute_shielded_vm_allowlist_constraint_v1_test.resource_changes as resource_changes

test_violation_with_shielded_vm_not_enabled {
  parameters := {
    # Test if parameter is not present, should be the most common situation
    #"enable_secure_boot": false
  }
  violations := violation with input.review as resource_changes[_]
    with input.parameters as parameters
  count(violations) == 1
}