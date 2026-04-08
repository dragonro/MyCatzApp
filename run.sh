#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

if [ ! -d "MyCatzApp.app" ]; then
  echo "MyCatzApp.app not found. Building..."
  ./build.sh
fi

echo "Launching MyCatzApp.app..."
open MyCatzApp.app
