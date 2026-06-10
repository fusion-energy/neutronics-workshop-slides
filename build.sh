#!/usr/bin/env bash
# Build all three workshop slide decks to standalone HTML files.
#
# Uses the Marp CLI Docker image so no local Node.js install is needed.
# The --html flag is required because the decks use raw HTML (columns,
# iframes, inline styles). The landing page (index.html) is hand written
# and is not built by this script.
#
# Usage: ./build.sh
set -euo pipefail

MARP="docker run --rm --init -v ${PWD}:/home/marp/app -e MARP_USER=$(id -u):$(id -g) marpteam/marp-cli"

build () {
  local src="$1" out="$2"
  echo "Building ${out} from ${src}"
  ${MARP} --html "${src}" -o "${out}"
}

build slides-full-day.md            full-day.html
build slides-half-day-conference.md half-day-conference.html
build slides-half-day-university.md half-day-university.html

echo "Done. Open index.html to access all three decks."
