#!/bin/bash

# Cross-platform build script for GitHub MCP Server

set -e

echo "🔨 Building GitHub MCP Server for all platforms..."

# Create dist directory
mkdir -p dist

# Build for Linux
echo "📦 Building for Linux (amd64)..."
GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o dist/github-mcp-server-linux .

# Build for macOS
echo "📦 Building for macOS (amd64)..."
GOOS=darwin GOARCH=amd64 go build -ldflags "-s -w" -o dist/github-mcp-server-macos .

# Build for Windows
echo "📦 Building for Windows (amd64)..."
GOOS=windows GOARCH=amd64 go build -ldflags "-s -w" -o dist/github-mcp-server.exe .

# Make binaries executable
chmod +x dist/github-mcp-server-*

echo "✅ Build complete! Binaries created:"
ls -la dist/

echo "
🚀 Ready for NPM packaging!
Run 'npm pack' to create .tgz file
Run 'npm publish' to publish to NPM"