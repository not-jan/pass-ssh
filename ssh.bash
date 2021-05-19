#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
shopt -s extglob

ssh_read_data() {
  local path="${1%/}"
  local passfile="$PREFIX/$path.gpg"
  check_sneaky_paths "$path"
  [[ ! -f $passfile ]] && die "$path: passfile not found."
  contents=$($GPG -d "${GPG_OPTS[@]}" "$passfile")

  read -r ssh_password < <(echo "$contents")

  while read -r line; do
  if [[ "$line" == ssh:* ]]; then
    local ssh_address=${line#"ssh:"}
    ssh_address=${ssh_address##+([[:space:]])}
  fi
  if [[ "$line" == sshflags:* ]]; then
    local ssh_flags=${line#"sshflags:"}
    ssh_flags=${ssh_flags##+([[:space:]])}
  fi
  done < <(echo "$contents")
  [[ -z ${ssh_address+x} ]] && die "$path: SSH host not defined."
  # Default value for flags
  ssh_flags="${ssh_flags:-}"

  export SSHPASS="$ssh_password"
  /usr/bin/sshpass -e -- ssh $ssh_flags "${@:2}" "$ssh_address"
}

ssh_read_data "$@"