@echo off
REM Cross-platform build script for GitHub MCP Server (Windows)

echo 🔨 Building GitHub MCP Server for all platforms...

REM Create dist directory
if not exist dist mkdir dist

REM Build for Linux
echo 📦 Building for Linux (amd64)...
set GOOS=linux
set GOARCH=amd64
go build -ldflags "-s -w" -o dist/github-mcp-server-linux .

REM Build for macOS
echo 📦 Building for macOS (amd64)...
set GOOS=darwin
set GOARCH=amd64
go build -ldflags "-s -w" -o dist/github-mcp-server-macos .

REM Build for Windows
echo 📦 Building for Windows (amd64)...
set GOOS=windows
set GOARCH=amd64
go build -ldflags "-s -w" -o dist/github-mcp-server.exe .

echo ✅ Build complete! Binaries created:
dir dist\

echo.
echo 🚀 Ready for NPM packaging!
echo Run 'npm pack' to create .tgz file
echo Run 'npm publish' to publish to NPM