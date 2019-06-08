#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC2128
ROOT="$(dirname $(dirname "${BASH_SOURCE}"))"
ROLES_ROOT="$ROOT/roles"

function role::new() {
    local -r role_name=${1:-""}
    if [[ -z "$role_name" ]]; then
        echo "Usage: new-role.sh {ROLE_NAME}"
        exit 1
    fi

    local -r role_root="${ROLES_ROOT}/${role_name}"
    for subdir in tasks defaults files templates; do
        local d="${role_root}/${subdir}"
        echo "Will create: ${d}"
        mkdir -p "$d"
        touch "$d/.gitignore"
    done
}

echo -n "Role name: "
read -r role_name
role::new "$role_name"
