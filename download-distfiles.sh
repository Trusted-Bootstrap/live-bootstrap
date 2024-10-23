#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2022 fosslinux <fosslinux@aussies.space>
#
# SPDX-License-Identifier: GPL-3.0-or-later

download_source() {
    local distfiles="${1}"
    local url="${2}"
    local checksum="${3}"
    local fname="${4}"
    # Default to basename of url if not given
    fname="${fname:-$(basename "${url}")}"

    local dest_path="${distfiles}/${fname}"
    if ! [ -e "${dest_path}" ]; then
        echo "Downloading ${fname}"
        curl --fail --location "${url}" --output "${dest_path}" || true
    fi
}

check_source() {
    local distfiles="${1}"
    local url="${2}"
    local checksum="${3}"
    local fname="${4}"
    # Default to basename of url if not given
    fname="${fname:-$(basename "${url}")}"

    local dest_path="${distfiles}/${fname}"
    echo "${checksum}  ${dest_path}" > tmp.sha256
    sha256sum --check tmp.sha256
    rm tmp.sha256
}

set -e

cd "$(dirname "$(readlink -f "$0")")"
mkdir -p distfiles

# First, try to download anything missing - ignore failing mirrors
for entry in steps/*; do
    [ -e "${entry}/sources" ] || continue

    # shellcheck disable=SC2162
    while read line; do
        # This is intentional - we want to split out ${line} into separate arguments.
        # shellcheck disable=SC2086
        download_source distfiles ${line}
    done < "${entry}/sources"
done

# Then, check if everything has been obtained at least once
for entry in steps/*; do
    [ -e "${entry}/sources" ] || continue

    # shellcheck disable=SC2162
    while read line; do
        # This is intentional - we want to split out ${line} into separate arguments.
        # shellcheck disable=SC2086
        check_source distfiles ${line}
    done < "${entry}/sources"
done
