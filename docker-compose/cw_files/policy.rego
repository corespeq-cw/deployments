# blah
# --------------------------------

package cwauth

import rego.v1

default allow := false

allow if {
        input.action in user_host_action
}

allow if {
        input.action in user_vm_action
}

allow if {
        input.action in user_cluster_action
}

allow if {
        input.action in user_host_action_global
}

allow if {
        input.action in user_vm_action_global
}

user_cluster_role contains role if {
        some clusterrole in data.cluster_roles
        input.user == clusterrole.user
        some role in clusterrole.roles
}

user_host_role contains role if {
        some hostrole in data.host_roles
        input.host == hostrole.host
        input.user == hostrole.user
        some role in hostrole.roles
}

user_vm_role contains role if {
        some vmrole in data.vm_roles
        input.host == vmrole.host
        input.user == vmrole.user
        input.resource == vmrole.vm
        some role in vmrole.roles
}

user_cluster_action contains action if {
        some role in user_cluster_role
        some role_grant in data.cluster_role_grants
        role_grant.role == role
        some action in role_grant.actions
}

user_host_action contains action if {
        some role in user_host_role
        some role_grant in data.host_role_grants
        role_grant.role == role
        some action in role_grant.actions
}

user_vm_action contains action if {
        some role in user_vm_role
        some role_grant in data.vm_role_grants
        role_grant.role == role
        some action in role_grant.actions
}

user_action contains action if {
        some action in user_vm_action
}

user_action contains action if {
        some action in user_host_action
}

user_action contains action if {
        some action in user_cluster_action
}

user_vm_role_global contains role if {
        some vmrole in data.vm_roles
        input.user == vmrole.user
        some role in vmrole.roles
}

user_vm_action_global contains action if {
        some role in user_vm_role_global
        some role_grant in data.vm_global_role_grants
        role_grant.role == role
        some action in role_grant.actions
}

user_host_role_global contains role if {
        some hostrole in data.host_roles
        input.user == hostrole.user
        some role in hostrole.roles
}

user_host_action_global contains action if {
        some role in user_host_role_global
        some role_grant in data.host_global_role_grants
        role_grant.role == role
        some action in role_grant.actions
}

user_action_global contains action if {
        some action in user_host_action_global
}

user_action_global contains action if {
        some action in user_vm_action_global
}
