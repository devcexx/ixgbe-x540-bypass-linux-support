#!/bin/bash
set -euo pipefail

repo_base_path=$(git rev-parse --show-toplevel)
linux_root="$repo_base_path/linux"
patches_root="$repo_base_path/patches"
(cd "$linux_root" && git am --committer-date-is-author-date "$patches_root/"*.patch)
