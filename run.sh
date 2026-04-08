#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

if [ ! -d "CATAI.app" ]; then
  echo "CATAI.app not found. Building..."
  ./build.sh
fi

echo "Launching CATAI.app..."
open CATAI.app
