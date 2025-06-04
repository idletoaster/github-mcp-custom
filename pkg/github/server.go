package github

import (
	"encoding/json"
	"errors"
	"fmt"

	"github.com/google/go-github/v72/github"
	"github.com/mark3labs/mcp-go/mcp"
	"github.com/mark3labs/mcp-go/server"
)

// DefaultTools represents the default list of available toolsets
var DefaultTools = []string{
	"repos",
	"issues", 
	"pull_requests",
	"code_security",
	"experiments",
}

// NewServer creates a new GitHub MCP server with the specified GH client and logger.
func NewServer(version string, opts ...server.ServerOption) *server.MCPServer {
	// Add default options
	defaultOpts := []server.ServerOption{
		server.WithToolCapabilities(true),
		server.WithResourceCapabilities(true, true),
		server.WithLogging(),
	}
	opts = append(defaultOpts, opts...)

	// Create a new MCP server
	s := server.NewMCPServer(
		"github-mcp-server",
		version,
		opts...,
	)
	return s
}

// Tool represents a GitHub MCP tool
type Tool struct {
	Name        string
	Description string
	InputSchema map[string]interface{}
}

// GetAvailableTools returns the list of available GitHub MCP tools
func GetAvailableTools() []Tool {
	return []Tool{
		{Name: "get_me", Description: "Get authenticated user details"},
		{Name: "search_repositories", Description: "Search GitHub repositories"},
		{Name: "get_file_contents", Description: "Read file contents from repos"},
		{Name: "create_repository", Description: "Create new repositories"},
		{Name: "get_issue", Description: "Get issue details"},
		{Name: "create_issue", Description: "Create new issues"},
		{Name: "get_pull_request", Description: "Get PR details"},
		{Name: "create_pull_request", Description: "Create new PRs"},
		{Name: "list_notifications", Description: "Get notifications"},
		// Add more tools as needed
	}
}