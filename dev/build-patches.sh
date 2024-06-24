#!/bin/bash
set -euo pipefail

repo_base_path=$(git rev-parse --show-toplevel)
base_commit=$(cat "$repo_base_path/dev/base_commit")
linux_root="$repo_base_path/linux"
patches_root="$repo_base_path/patches"
(cd "$linux_root" && git format-patch "$base_commit" --no-numbered -o "$patches_root")
