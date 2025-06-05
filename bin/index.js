#!/usr/bin/env node

const os = require("os");
const { spawn } = require("child_process");
const path = require("path");
const fs = require("fs");

let executable = "github-mcp-server";
const platform = os.platform();

if (platform === "win32") {
  executable += ".exe";
} else if (platform === "darwin") {
  executable += "-macos";
} else {
  executable += "-linux";
}

const binaryPath = path.resolve(__dirname, "..", "dist", executable);

if (!fs.existsSync(binaryPath)) {
  console.error(`GitHub MCP Server binary not found: ${executable}`);
  console.error(`Expected at: ${binaryPath}`);
  console.error(`\nTo build binaries, run:\n  npm run build\n`);
  process.exit(1);
}

const args = process.argv.slice(2);

const child = spawn(binaryPath, args, {
  stdio: "inherit",
});

child.on("error", (err) => {
  console.error("Failed to start GitHub MCP Server:", err.message);
  process.exit(1);
});

child.on("exit", (code) => process.exit(code));