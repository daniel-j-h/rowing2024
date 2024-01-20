#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# This is really brittle and prone to errors; but instead of
# spending time fixing it I'd rather row another 10k or so :D

# as in https://log.concept2.com/profile/1579258
readonly profileId=1579258
# concept2 logbook only gives total; what was the total at the start?
readonly yearStartMeters=2549051

readonly totalMeters=$(curl -sSf --proto =https --tlsv1.3 "https://log.concept2.com/profile/$profileId" \
  | grep -F -B3 'Lifetime Meters' | head -n 1 | tr -cd '[:digit:]')

readonly metersThisYear="$((totalMeters - yearStartMeters))"

sed -i "s/const metersThisYear.*/const metersThisYear=${metersThisYear};/g" index.html
