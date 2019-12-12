#!/usr/bin/env bash

set -euCo pipefail

function main() {
  usage=$(free -h | awk 'match($0, /^Mem/){print $3 " / " $2}')
  usage_percent=$(free -b | awk 'match($0, /^Mem/){print int($3 * 1000 / $2) / 10}')
  echo " ${usage} : ${usage_percent}%"
}

main
