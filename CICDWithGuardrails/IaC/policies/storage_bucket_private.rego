package terraform

# Check Bucket Access Control
deny[msg] {
    changeset := input.resource_changes[_]
    is_create_or_update(changeset.change.actions)
    changeset.type == "google_storage_bucket_access_control"
    changeset.change.after.predefined_acl == "Public"
    msg := sprintf("%-40s :: GCS buckets must not be PUBLIC", [
        changeset.name
    ])
}

# Check google_storage_bucket_acl for predefined ACL's
deny[msg] {
    bad_acls := [ "publicRead", "publicReadWrite" ]
    changeset := input.resource_changes[_]
    is_create_or_update(changeset.change.actions)
    changeset.type == "google_storage_bucket_acl"
    changeset.change.after.predefined_acl == bad_acls[_]
    msg := sprintf("%-40s :: GCS buckets must not use predefined ACL '%s'", [
        changeset.name, changeset.change.after.predefined_acl
    ])
}

is_create_or_update(actions) { actions[_] == "create" }
is_create_or_update(actions) { actions[_] == "update" }