# GitHub MCP Custom (Cross-Platform NPX Wrapper)

A custom-packaged version of the [GitHub MCP Server](https://github.com/github/github-mcp-server) that runs seamlessly on **Windows**, **Linux**, and **macOS** via `npx`. This wraps the Go binary in a Node.js launcher so developers using Claude Desktop can use GitHub MCP capabilities with no Docker or manual compilation required.

---

## 📦 Why This Exists

The official GitHub MCP Server requires:
- Docker or
- Manual Go compilation.

These options work well on Linux/macOS, but **break or complicate Windows usage**.

This package makes the server available via `npx`, eliminating the need for:
- Docker
- Go installation
- Custom PATH setups

---

## 🧠 What This Package Does

- Provides a cross-platform `github-mcp-custom` command
- Executes the prebuilt Go binary via Node.js wrapper
- Fully NPX-compatible on all OSes
- Works out-of-the-box with Claude Desktop or other MCP-compatible tools
- **Protocol version compatible with Claude Desktop**

---

## 🚀 Installation & Usage

### 🔹 Option 1: Run with NPX (Recommended)

```bash
npx -y github-mcp-custom@1.0.20 stdio
```

> First-time use will download the package and run it automatically.

### 🔹 Option 2: Install Globally

```bash
npm install -g github-mcp-custom@1.0.20
github-mcp-custom stdio
```

### 🔹 Option 3: Direct Executable (Windows Fallback)

If NPX has issues on Windows, use the direct path:

```json
{
  "mcpServers": {
    "github": {
      "command": "C:\\Users\\[USERNAME]\\AppData\\Roaming\\npm\\node_modules\\github-mcp-custom\\dist\\github-mcp-server.exe",
      "args": ["stdio"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

Replace `[USERNAME]` with your actual Windows username.

**Note:** Use `@1.0.20` or later for optimal Claude Desktop compatibility.

---

## 🛠️ Prerequisites

- [Node.js](https://nodejs.org) v14 or later must be installed
- An active GitHub Personal Access Token with proper scopes:
  - `repo` (for repository access)
  - `read:org` (for organization access)
  - `user` (for user information)

---

## 🔐 Creating a GitHub Personal Access Token

1. Go to [GitHub Settings > Developer Settings > Personal Access Tokens](https://github.com/settings/tokens)
2. Click "Generate new token (classic)"
3. Select these scopes:
   - ✅ `repo` - Full control of private repositories
   - ✅ `read:org` - Read org and team membership
   - ✅ `user` - Update user data
4. Copy the generated token

---

## 🖥️ Claude Desktop Configuration

### Windows

Add this to your Claude Desktop configuration file located at:
`%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "github-mcp-custom@1.0.20", "stdio"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

### macOS

Add this to your Claude Desktop configuration file located at:
`~/Library/Application Support/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "github-mcp-custom@1.0.20", "stdio"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

### Linux

Add this to your Claude Desktop configuration file located at:
`~/.config/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "github-mcp-custom@1.0.20", "stdio"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

### Alternative Global Installation Configuration

If you've installed globally, you can use:

```json
{
  "mcpServers": {
    "github": {
      "command": "github-mcp-custom",
      "args": ["stdio"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

---

## 🎯 Available Tools & Capabilities

Once configured, you'll have access to these GitHub MCP tools:

### 📂 **Repository Management**
- `search_repositories` - Search GitHub repositories
- `get_file_contents` - Read file contents from repos
- `create_or_update_file` - Create/modify files
- `create_repository` - Create new repositories
- `fork_repository` - Fork repositories
- `create_branch` - Create branches
- `push_files` - Push file changes
- `list_commits` - View commit history
- `get_commit` - Get specific commit details

### 🐛 **Issues & Project Management**
- `get_issue` - Get issue details with timestamps
- `create_issue` - Create new issues
- `update_issue` - Update issues (returns updated info with timestamps)
- `search_issues` - Search across issues
- `list_issues` - List repository issues
- `get_issue_comments` - Get issue comments with timestamps
- `add_issue_comment` - Add comments to issues

### 🔄 **Pull Requests**
- `get_pull_request` - Get PR details
- `create_pull_request` - Create new PRs
- `update_pull_request` - Update existing PRs
- `merge_pull_request` - Merge PRs
- `get_pull_request_files` - See PR changes
- `get_pull_request_comments` - Get PR comments
- `create_and_submit_pull_request_review` - Review PRs

### 🔒 **Security & Scanning**
- `list_code_scanning_alerts` - Code security alerts
- `list_secret_scanning_alerts` - Secret scanning alerts

### 🔔 **Notifications**
- `list_notifications` - Get notifications
- `dismiss_notification` - Dismiss notifications
- `mark_all_notifications_read` - Mark all as read

### 👤 **User & Context**
- `get_me` - Get authenticated user details
- `search_users` - Search GitHub users

---

## 🧪 Testing Your Setup

1. **Test the command directly:**
   ```bash
   npx -y github-mcp-custom@1.0.20 stdio
   ```
   Should output: `GitHub MCP Server running on stdio`

2. **Test with Claude Desktop:**
   - Restart Claude Desktop after updating the config
   - Try asking: "Can you get my GitHub user information?"
   - Claude should be able to use the `get_me` tool

---

## 🔧 Troubleshooting

### Common Issues

**❌ "Server disconnected" in Claude Desktop**
- Ensure you're using version `1.0.20` or later
- Check that your GitHub token is valid and has proper scopes
- Verify the JSON configuration is valid (no trailing commas)

**❌ "Command not found"**
- Make sure Node.js is installed and in your PATH
- Try running `npm --version` to verify npm is working

**❌ "Authentication failed"**
- Verify your GitHub Personal Access Token is correct
- Check that the token has the required scopes (`repo`, `read:org`, `user`)
- Make sure the token hasn't expired

**❌ "Method not found" errors**
- Update to the latest version: `npm install -g github-mcp-custom@latest`

---

## 📁 Source Code

**Note:** This repository contains the essential source files. For the complete original GitHub MCP Server source code, visit the [official repository](https://github.com/github/github-mcp-server).

```
github-mcp-custom/
├── cmd/github-mcp-server/
│   ├── cmd/github-mcp-server/main.go  # Main entry point
│   └── go.mod                         # Go dependencies
├── package.json                       # NPM package configuration
├── go.mod                            # Root Go module
└── README.md                         # This file
```

To build from source, you'll need the complete source code from the official repository.

---

## 🖥️ Platform Compatibility

| Platform        | Tested | Notes                   |
|-----------------|--------|-------------------------|
| ✅ Windows 10/11 | ✔️      | No Docker or Go needed  |
| ✅ Linux (Ubuntu) | ✔️      | Works out-of-the-box    |
| ✅ macOS (Intel/M1) | ✔️   | Works with NPX easily   |

---

## 📈 Version History

- **v1.0.20** - Fixed Claude Desktop protocol compatibility
- **v1.0.18** - Working version with protocol fixes
- **v1.0.17** - Protocol compatibility improvements
- **v1.0.16** - Previous version (had connection issues)

---

## 👷 How This Was Built

1. Cloned the official GitHub MCP Server repository
2. Updated mcp-go library from v0.30.0 to v0.26.0 for Claude Desktop protocol compatibility
3. Compiled Go binaries for all platforms:
   ```bash
   GOOS=linux GOARCH=amd64 go build -o dist/github-mcp-server-linux ./cmd/github-mcp-server
   GOOS=darwin GOARCH=amd64 go build -o dist/github-mcp-server-macos ./cmd/github-mcp-server  
   GOOS=windows GOARCH=amd64 go build -o dist/github-mcp-server.exe ./cmd/github-mcp-server
   ```
4. Created a Node.js wrapper script for cross-platform execution
5. Set up NPM-compatible `package.json` with proper bin configuration
6. Published the package with protocol compatibility fixes

---

## 🤝 Contributing

Contributions are welcome! Please visit our GitHub repository:

**🔗 Repository:** https://github.com/idletoaster/github-mcp-custom

- 🐛 **Report issues:** [GitHub Issues](https://github.com/idletoaster/github-mcp-custom/issues)
- 💡 **Feature requests:** [GitHub Discussions](https://github.com/idletoaster/github-mcp-custom/discussions)
- 🔧 **Pull requests:** Welcome for improvements and fixes

---

## 📜 License

MIT License

Copyright (c) 2025 idletoaster

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
