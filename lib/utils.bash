#!/usr/bin/env bash

set -euo pipefail

# GitHub repository information
readonly GITHUB_REPO="facebook/ktfmt"
readonly TOOL_NAME="ktfmt"

# Get the download URL for a specific version
get_download_url() {
  local version="$1"
  echo "https://github.com/${GITHUB_REPO}/releases/download/v${version}/${TOOL_NAME}-${version}-with-dependencies.jar"
}

# Sort versions in descending order
sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

# List all available versions from GitHub releases
list_github_tags() {
  git ls-remote --tags --refs "https://github.com/${GITHUB_REPO}.git" |
    grep -o 'refs/tags/v.*' |
    cut -d/ -f3- |
    sed 's/^v//' |
    sort_versions |
    tail -r 2>/dev/null || sort_versions | sort -r
}

# Check if Java is available
check_java() {
  if ! command -v java >/dev/null 2>&1; then
    echo "Error: Java is required to run ktfmt but was not found in PATH" >&2
    echo "Please install Java 11 or later" >&2
    exit 1
  fi

  # Check Java version (ktfmt requires Java 11+)
  local java_version
  java_version=$(java -version 2>&1 | head -n1 | cut -d'"' -f2 | cut -d'.' -f1-2)
  local major_version
  major_version=$(echo "$java_version" | cut -d'.' -f1)
  
  # Handle Java 9+ version format (e.g., "11.0.1") vs older format (e.g., "1.8.0")
  if [[ "$major_version" == "1" ]]; then
    major_version=$(echo "$java_version" | cut -d'.' -f2)
  fi

  if [[ "$major_version" -lt 11 ]]; then
    echo "Error: ktfmt requires Java 11 or later, but found Java $java_version" >&2
    exit 1
  fi
}

# Download file with curl or wget
download_file() {
  local url="$1"
  local output_path="$2"
  
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$output_path"
  elif command -v wget >/dev/null 2>&1; then
    wget -q "$url" -O "$output_path"
  else
    echo "Error: Neither curl nor wget is available for downloading" >&2
    exit 1
  fi
}

# Ensure directory exists
ensure_dir() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
  fi
}