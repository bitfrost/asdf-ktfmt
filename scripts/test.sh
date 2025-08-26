#!/usr/bin/env bash

set -euo pipefail

# Test script for asdf-ktfmt plugin

echo "Testing asdf-ktfmt plugin..."

# Test 1: Check if required scripts exist and are executable
echo "✓ Checking required scripts..."
for script in bin/list-all bin/download bin/install; do
  if [[ ! -f "$script" ]]; then
    echo "✗ Missing required script: $script"
    exit 1
  fi
  if [[ ! -x "$script" ]]; then
    echo "✗ Script not executable: $script"
    exit 1
  fi
done

# Test 2: Check if lib/utils.bash exists
echo "✓ Checking utility functions..."
if [[ ! -f "lib/utils.bash" ]]; then
  echo "✗ Missing lib/utils.bash"
  exit 1
fi

# Test 3: Test list-all functionality
echo "✓ Testing list-all script..."
versions=$(./bin/list-all)
if [[ -z "$versions" ]]; then
  echo "✗ list-all returned no versions"
  exit 1
fi

# Check if latest version (0.57) is in the list
if [[ "$versions" != *"0.57"* ]]; then
  echo "✗ Expected version 0.57 not found in versions list"
  exit 1
fi

echo "✓ Found versions: $(echo "$versions" | tr ' ' '\n' | head -5 | tr '\n' ' ')..."

# Test 4: Check if utils functions can be sourced
echo "✓ Testing utility functions..."
# shellcheck source=lib/utils.bash
source lib/utils.bash

# Test get_download_url function
test_url=$(get_download_url "0.57")
expected_url="https://github.com/facebook/ktfmt/releases/download/v0.57/ktfmt-0.57-with-dependencies.jar"
if [[ "$test_url" != "$expected_url" ]]; then
  echo "✗ get_download_url test failed"
  echo "  Expected: $expected_url"
  echo "  Got: $test_url"
  exit 1
fi

echo "✓ All tests passed!"
echo ""
echo "Plugin structure:"
find . -type f -name "*.bash" -o -name "*.sh" -o -path "./bin/*" | sort