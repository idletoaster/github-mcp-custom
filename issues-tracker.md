# GitHub MCP Custom - Issues Tracker

## Project Overview
This document tracks all issues, bugs, and feature requests for the GitHub MCP Custom integration with Claude Desktop.

---

## Active Issues

### Issue #001 - MCP Server Disconnect After Initialization
**Status:** 🔴 Open  
**Priority:** High  
**Created:** 2025-06-04  
**Assignee:** TBD

**Description:**
GitHub MCP server successfully initializes and completes handshake but immediately disconnects, preventing Claude Desktop from maintaining connection.

**Symptoms:**
- Server starts and connects successfully
- Initialization message exchange completes normally
- Server transport closes unexpectedly immediately after handshake
- Pattern repeats across multiple connection attempts

**Log Evidence:**
```
GitHub MCP Server running on stdio
Message from server: {"jsonrpc":"2.0","id":0,"result":{"protocolVersion":"2025-03-26"...}}
Client transport closed
Server transport closed unexpectedly
```

**Root Cause Identified:**
Missing 'github-mcp-server' in npx args array. User had 'stdio' instead of the correct server script name.

**Current Config:**
```json
"args": ["-y", "github-mcp-custom@1.0.14", "stdio"]
```

**Corrected Config:**
```json
"args": ["-y", "github-mcp-custom@1.0.14", "github-mcp-server"]
```
**Progress Log:**
- 2025-06-04: Issue identified from log analysis
- 2025-06-04: Created issues tracker system
- 2025-06-04: Analyzed user's MCP configuration
- 2025-06-04: **ROOT CAUSE FOUND:** Missing server script in npx command arguments
- 2025-06-04: Provided corrected configuration to user
- 2025-06-04: **WAITING:** User testing corrected configuration

---

## Resolved Issues
*No resolved issues yet*

---

## Feature Requests
*No feature requests yet*

---

## Issue Management Guidelines

### Status Indicators
- 🔴 Open - Issue is active and needs attention
- 🟡 In Progress - Currently being worked on
- 🟢 Resolved - Issue has been fixed and verified
- ⚫ Closed - Issue closed without resolution

### Priority Levels
- **Critical:** System unusable, blocks all functionality
- **High:** Major feature broken, significant impact
- **Medium:** Minor feature issue, workaround available
- **Low:** Enhancement or nice-to-have

### Approval Process
All issue closures require user approval before moving to resolved status.

---

*Last Updated: 2025-06-04 18:30 UTC*
- 2025-06-04: **UPDATE:** Configuration fix didn't resolve issue - Windows path resolution problem
- 2025-06-04: **NEW ROOT CAUSE:** npx on Windows can't resolve path to github-mcp-server executable
- 2025-06-04: **PROPOSED SOLUTION:** Use direct installation method instead of npx
**SOLUTION ATTEMPT #2: Global Installation Approach**
- 2025-06-04: **NEW APPROACH:** Installing github-mcp-custom@1.0.16 globally
- 2025-06-04: **COMMAND:** npm install -g github-mcp-custom@1.0.16
- 2025-06-04: **CONFIG CHANGE:** Using direct 'github-mcp-server' command instead of npx
- 2025-06-04: **STATUS:** Waiting for user testing
**SOLUTION ATTEMPT #2 FAILED: Global Installation Error**
- 2025-06-04: **ERROR:** npm install -g fails due to --postinstall flag not recognized
- 2025-06-04: **ISSUE:** Package postinstall script has bug with unknown --postinstall flag
- 2025-06-04: **DISCOVERY:** Binary exists at dist/github-mcp-server.exe with stdio command available

**SOLUTION ATTEMPT #3: Direct Binary Execution**
- 2025-06-04: **NEW APPROACH:** Try executing the binary directly with stdio command
- 2025-06-04: **STATUS:** Testing direct binary path approach
**SOLUTION ATTEMPT #3 SUCCESS: Global Install with --ignore-scripts**
- 2025-06-04: **SUCCESS:** npm install -g github-mcp-custom@1.0.16 --ignore-scripts worked
- 2025-06-04: **RESULT:** Package installed successfully, bypassing postinstall script bug
- 2025-06-04: **NEXT:** Testing direct github-mcp-server command in Claude Desktop config
**SOLUTION ATTEMPT #3 FAILED: Command Not Found**
- 2025-06-04: **ERROR:** spawn github-mcp-server ENOENT (command not found in PATH)
- 2025-06-04: **ISSUE:** Global install didn't add github-mcp-server to PATH properly
- 2025-06-04: **NEED:** Find exact path to installed executable

**SOLUTION ATTEMPT #4: Use Full Path to Executable**
- 2025-06-04: **APPROACH:** Use full path instead of relying on PATH
- 2025-06-04: **STATUS:** Locating installed executable path
**SOLUTION ATTEMPT #4: Full Path to Windows Executable**
- 2025-06-04: **FOUND:** github-mcp-server.exe at C:\\Users\\autumdance\\AppData\\Roaming\\npm\\node_modules\\github-mcp-custom\\dist\\github-mcp-server.exe
- 2025-06-04: **CONFIG:** Using full path with "stdio" argument
- 2025-06-04: **STATUS:** Ready for testing - this should resolve the ENOENT error
**SOLUTION ATTEMPT #4 PARTIAL SUCCESS: Server Runs but Protocol Mismatch**
- 2025-06-04: **SUCCESS:** Server executable now runs and completes handshake
- 2025-06-04: **ISSUE:** Protocol version mismatch causing disconnect
- 2025-06-04: **CLIENT:** Expects protocolVersion 2024-11-05
- 2025-06-04: **SERVER:** Responds with protocolVersion 2025-03-26
- 2025-06-04: **RESULT:** Server exits after successful initialization due to version incompatibility

**SOLUTION ATTEMPT #5: Address Protocol Version Compatibility**
- 2025-06-04: **APPROACH:** Check if server supports older protocol version or if Claude Desktop needs update
- 2025-06-04: **STATUS:** Investigating compatibility options
**ROOT CAUSE IDENTIFIED: Missing GitHub Token Authentication**
- 2025-06-04: **CODE ANALYSIS:** Examined main.go source code
- 2025-06-04: **ISSUE FOUND:** Server exits because GITHUB_PERSONAL_ACCESS_TOKEN is not properly set
- 2025-06-04: **CODE:** Server checks for token and exits with error if missing
- 2025-06-04: **ENVIRONMENT:** Need to ensure token is properly passed to server process

**SOLUTION ATTEMPT #6: Fix Environment Variable**
- 2025-06-04: **APPROACH:** Ensure GITHUB_PERSONAL_ACCESS_TOKEN reaches the spawned process
- 2025-06-04: **STATUS:** Testing environment variable configuration
**SOLUTION ATTEMPT #6 SUCCESS: Manual Execution Works**
- 2025-06-04: **SUCCESS:** Manual execution with stdio argument works perfectly
- 2025-06-04: **CONFIRMATION:** Server runs and stays alive when executed directly
- 2025-06-04: **NEXT:** Test with real GitHub token and update Claude Desktop config
- 2025-06-04: **STATUS:** Ready for final configuration with actual token
**SOLUTION ATTEMPT #7: Node.js Wrapper Approach**
- 2025-06-04: **ISSUE:** Direct executable works manually but fails in Claude Desktop
- 2025-06-04: **APPROACH:** Using Node.js to run the wrapper script instead of direct executable
- 2025-06-04: **REASONING:** Claude Desktop may handle Node.js processes better than direct binary execution
- 2025-06-04: **STATUS:** Testing Node.js wrapper configuration
**SOLUTION ATTEMPT #7 FAILED: Debug Output Interferes with JSON-RPC**
- 2025-06-04: **ISSUE:** Node.js wrapper sends debug messages to stdout
- 2025-06-04: **PROBLEM:** Claude Desktop expects only JSON-RPC messages on stdout
- 2025-06-04: **ERROR:** "Unexpected token" because debug emojis are not valid JSON
- 2025-06-04: **SOLUTION:** Need to suppress debug output or redirect it

**SOLUTION ATTEMPT #8: Back to Direct Executable**
- 2025-06-04: **APPROACH:** Return to direct executable but investigate environment variable issue
- 2025-06-04: **STATUS:** Testing direct executable with environment troubleshooting
**SOLUTION ATTEMPT #8 RESULT: Empty Log File**
- 2025-06-04: **OBSERVATION:** Log file created but remains empty
- 2025-06-04: **ANALYSIS:** Server exits before writing any log entries
- 2025-06-04: **PATTERN:** Server completes handshake then immediately exits
- 2025-06-04: **SUSPICION:** Protocol version mismatch may be causing silent exit

**FINAL SOLUTION ATTEMPT: Check GitHub Issue/Try Alternative**
- 2025-06-04: **STATUS:** Investigating if this is a known compatibility issue
**SOLUTION ATTEMPT #9: Enhanced Logging Configuration**
- 2025-06-04: **DISCOVERY:** Server supports --enable-command-logging flag
- 2025-06-04: **APPROACH:** Using enhanced logging to capture request/response details
- 2025-06-04: **FLAGS AVAILABLE:** --dynamic-toolsets, --enable-command-logging, --read-only, --toolsets
- 2025-06-04: **STATUS:** Testing with command logging enabled
**BREAKTHROUGH: Protocol Version Mismatch Confirmed**
- 2025-06-04: **SUCCESS:** Custom log captured the exact communication
- 2025-06-04: **ISSUE CONFIRMED:** Protocol version mismatch is the root cause
- 2025-06-04: **CLIENT:** Claude Desktop requests protocolVersion "2024-11-05"
- 2025-06-04: **SERVER:** Responds with protocolVersion "2025-03-26"
- 2025-06-04: **RESULT:** Claude Desktop disconnects due to incompatible protocol version
- 2025-06-04: **STATUS:** Need solution for protocol compatibility
**SOLUTION ATTEMPT #10: Official GitHub MCP Server**
- 2025-06-04: **DISCOVERY:** Found official @modelcontextprotocol/server-github
- 2025-06-04: **VERSION:** 2025.4.8 (published 2025-04-08)
- 2025-06-04: **MAINTAINERS:** Same as other working MCP servers (jspahrsummers, thedsp, ashwin-ant)
- 2025-06-04: **APPROACH:** Install official server for better protocol compatibility
- 2025-06-04: **STATUS:** Testing official implementation
**IMPORTANT CLARIFICATION:**
- 2025-06-04: **USER CONTEXT:** github-mcp-custom is user's custom NPX wrapper for official GitHub MCP
- 2025-06-04: **PURPOSE:** Avoids Docker requirement on Windows, enables NPX usage
- 2025-06-04: **GOAL:** Make official GitHub MCP work with Claude Desktop via NPX
- 2025-06-04: **ISSUE:** Protocol version mismatch between official MCP (2025-03-26) and Claude Desktop (2024-11-05)

**REAL SOLUTION NEEDED: Protocol Compatibility**
- 2025-06-04: **CHALLENGE:** Need to bridge protocol version gap
- 2025-06-04: **OPTIONS:** Either update Claude Desktop or modify server protocol response
- 2025-06-04: **STATUS:** Investigating protocol compatibility solutions
**SOLUTION ATTEMPT #10: Modify Protocol Version in Source**
- 2025-06-04: **FOUND:** Protocol version "2025-03-26" referenced in e2e_test.go
- 2025-06-04: **NEXT:** Search for actual protocol version definition in main code
- 2025-06-04: **PLAN:** Change protocol version to "2024-11-05" for Claude Desktop compatibility
- 2025-06-04: **STATUS:** Locating protocol version definition
**ROOT CAUSE CONFIRMED: mcp-go Library Version Too New**
- 2025-06-04: **FOUND:** Protocol version comes from mcp-go library v0.30.0
- 2025-06-04: **ISSUE:** mcp-go v0.30.0 uses protocol version "2025-03-26"  
- 2025-06-04: **CLAUDE DESKTOP:** Expects protocol version "2024-11-05"
- 2025-06-04: **SOLUTION:** Downgrade mcp-go to version compatible with "2024-11-05"

**SOLUTION IMPLEMENTATION: Downgrade mcp-go Library**
- 2025-06-04: **APPROACH:** Update go.mod to use older mcp-go version
- 2025-06-04: **TARGET:** Find mcp-go version that uses "2024-11-05" protocol
- 2025-06-04: **STATUS:** Ready to implement library downgrade
**SOLUTION IMPLEMENTED: Updated go.mod for Protocol Compatibility**
- 2025-06-04: **COMPLETED:** Updated go.mod to use mcp-go v0.25.0 (downgraded from v0.30.0)
- 2025-06-04: **TARGET:** v0.25.0 should use compatible protocol version "2024-11-05"
- 2025-06-04: **READY:** Files updated for migration to LXE server
- 2025-06-04: **NEXT:** User will migrate files, rebuild, and republish to NPM

**FILES UPDATED:**
- go.mod: Changed mcp-go from v0.30.0 to v0.25.0
- e2e_test.go: Needs manual update of protocol version from "2025-03-26" to "2024-11-05"

**STATUS:** Ready for LXE server migration and rebuild
**ALL FILES UPDATED SUCCESSFULLY ✅**
- 2025-06-04: **COMPLETED:** Updated go.mod to use mcp-go v0.25.0
- 2025-06-04: **COMPLETED:** Updated e2e_test.go protocol version to "2024-11-05"
- 2025-06-04: **STATUS:** All files ready for LXE server migration and rebuild

**FILES UPDATED:**
✅ go.mod: Changed mcp-go from v0.30.0 to v0.25.0
✅ e2e_test.go: Changed protocol version from "2025-03-26" to "2024-11-05"

**READY FOR:** Migration to LXE server, rebuild, and NPM republish
**SETUP SCRIPT ANALYSIS: ./setup-mcp.sh**
- 2025-06-04: **FOUND:** Script automates entire build and package process
- 2025-06-04: **ISSUE:** Still has postinstall script that causes installation failure
- 2025-06-04: **ISSUE:** Version hardcoded to 1.0.16, should be 1.0.17 for new release
- 2025-06-04: **NEED:** Remove problematic postinstall script
- 2025-06-04: **NEED:** Update version to 1.0.17
**SOLUTION COMPLETED: README.md Updated**
- 2025-06-04: **COMPLETED:** Comprehensive README update with platform-specific instructions
- 2025-06-04: **ADDED:** Claude Desktop configuration for Windows, macOS, and Linux
- 2025-06-04: **ADDED:** Complete tools and capabilities documentation
- 2025-06-04: **ADDED:** Troubleshooting section with common issues
- 2025-06-04: **ADDED:** GitHub token setup instructions
- 2025-06-04: **UPDATED:** Version references to 1.0.17

**FILES READY FOR LXE MIGRATION:**
✅ setup-mcp.sh (updated)
✅ cmd/github-mcp-server/go.mod (updated)  
✅ cmd/github-mcp-server/e2e/e2e_test.go (updated)
✅ README.md (updated)

**READY FOR:** Final migration and NPM publish
**README UPDATE CONFIRMED:**
- 2025-06-04: **UPDATED:** Main NPM package README at github-mcp-custom/README.md ✅
- 2025-06-04: **LOCATION:** C:\Users\autumdance\Documents\Personal folder\Claude-Projects\github-mcp-server\github-mcp-custom\README.md
- 2025-06-04: **NOTE:** This is the README users see when installing via NPM
- 2025-06-04: **SEPARATE:** Original server README at cmd/github-mcp-server/README.md (unchanged)

**FINAL FILES FOR LXE MIGRATION:**
✅ setup-mcp.sh (updated)
✅ cmd/github-mcp-server/go.mod (updated)  
✅ cmd/github-mcp-server/e2e/e2e_test.go (updated)
✅ README.md (updated) - Main package README for NPM users
**README FIXED: Removed GitHub Dependencies**
- 2025-06-04: **REMOVED:** Non-existent GitHub issues page link
- 2025-06-04: **CHANGED:** "idletoaster" to "[Author Name]" placeholder
- 2025-06-04: **UPDATED:** Contributing section to mention future GitHub repository
- 2025-06-04: **REASON:** Repository not yet pushed to GitHub due to connection issues

**WORKFLOW PLAN:**
1. Publish NPM package first with working MCP
2. Test GitHub connectivity with working MCP
3. Push repository to GitHub for collaboration
4. Update README with actual GitHub links and author info
**BUILD FAILURE: mcp-go v0.25.0 Incompatibility**
- 2025-06-04: **ERROR:** Build failed on LXE server
- 2025-06-04: **ISSUE:** ReadOnlyHint field structure incompatible with v0.25.0
- 2025-06-04: **ROOT CAUSE:** Code expects pointer (*bool) but v0.25.0 uses bool directly
- 2025-06-04: **OPTIONS:** Fix code or find compatible mcp-go version

**IMMEDIATE SOLUTION NEEDED:**
Either update the code to match v0.25.0 API or find mcp-go version compatible with current code
**SOLUTION ATTEMPT #11: Try mcp-go v0.28.0**
- 2025-06-04: **APPROACH:** Update to newer mcp-go version that might have compatible protocol
- 2025-06-04: **VERSION:** Trying v0.28.0 instead of v0.25.0
- 2025-06-04: **GOAL:** Find version with correct API structure and compatible protocol
- 2025-06-04: **STATUS:** Preparing updated go.mod for v0.28.0
**UPDATE: Trying mcp-go v0.29.0 Instead**
- 2025-06-04: **FOUND:** Many files use ReadOnlyHint with pointer dereferencing (*ReadOnlyHint)
- 2025-06-04: **ISSUE:** Would need to update ~50+ files if API changed significantly
- 2025-06-04: **STRATEGY:** Try v0.29.0 first - closer to original v0.30.0 but might have compatible protocol
- 2025-06-04: **FILES:** Only go.mod updated so far

**FOR MIGRATION:**
✅ cmd/github-mcp-server/go.mod (updated to v0.29.0)

**IF v0.29.0 FAILS:**
Will need to either find the exact compatible version or update the ReadOnlyHint usage pattern
**CURRENT STATUS: Testing mcp-go v0.29.0 Compatibility**
- 2025-06-04: **APPROACH:** Using version closer to original for better API compatibility
- 2025-06-04: **DISCOVERY:** 50+ files use ReadOnlyHint pattern with pointer dereferencing
- 2025-06-04: **MIGRATION:** Only go.mod updated to v0.29.0
- 2025-06-04: **WAITING:** LXE server test results

**ANALYSIS:**
- Original issue: Protocol version mismatch (v0.30.0 uses "2025-03-26", Claude wants "2024-11-05")
- v0.25.0 caused API compatibility issues (ReadOnlyHint structure changed)
- v0.29.0 strategy: Balance between protocol compatibility and API compatibility

**IF v0.29.0 FAILS:**
Next options:
1. Try v0.27.0, v0.26.0 systematically
2. Find exact version with "2024-11-05" protocol
3. Update all ReadOnlyHint usage (extensive code changes)
4. Custom patch approach

**SUCCESS CRITERIA:**
✅ Clean build without API errors
✅ Compatible protocol version with Claude Desktop
✅ Working MCP tools and capabilities
**🎉 SUCCESS: Build Completed with mcp-go v0.29.0**
- 2025-06-04: **✅ BUILD SUCCESS:** No compilation errors
- 2025-06-04: **✅ API COMPATIBLE:** ReadOnlyHint structure works with v0.29.0
- 2025-06-04: **✅ BINARIES BUILT:** Linux, macOS, Windows binaries created
- 2025-06-04: **✅ PACKAGE READY:** v1.0.17 prepared for NPM publish
- 2025-06-04: **🚀 STATUS:** User publishing to NPM now

**SOLUTION FOUND:**
mcp-go v0.29.0 provides the perfect balance:
- API compatible with existing code (ReadOnlyHint works)
- Potentially compatible protocol version with Claude Desktop
- Successfully builds cross-platform binaries

**NEXT:** Test Claude Desktop connectivity after NPM publish
**🎉 MILESTONE: NPM PACKAGE PUBLISHED SUCCESSFULLY**
- 2025-06-04: **✅ PUBLISHED:** github-mcp-custom@1.0.17 live on NPM
- 2025-06-04: **📦 FILES:** 6 files included (binaries, config, docs)
- 2025-06-04: **🌍 AVAILABLE:** Worldwide installation via npm/npx
- 2025-06-04: **🔥 READY:** For Claude Desktop testing

**NEXT PHASE: TESTING**
- Test Claude Desktop connectivity with v1.0.17
- Verify protocol compatibility 
- Check GitHub MCP tools functionality
- If successful: Issue #001 can be marked RESOLVED!
**🎉 FINAL SUCCESS: Issue #001 RESOLVED ✅**
- 2025-06-04: **✅ CONFIRMED:** Direct executable path with v1.0.18 works perfectly
- 2025-06-04: **✅ ALL TOOLS LOADED:** 40+ GitHub MCP tools available and functional
- 2025-06-04: **✅ NO DISCONNECTS:** Server maintains stable connection with Claude Desktop
- 2025-06-04: **✅ PROTOCOL FIXED:** mcp-go v0.26.0 provides compatible "2024-11-05" protocol
- 2025-06-04: **✅ LOG EVIDENCE:** Full tool listing and successful communication captured

**FINAL WORKING CONFIGURATION:**
```json
"github": {
  "command": "C:\\Users\\autumdance\\AppData\\Roaming\\npm\\node_modules\\github-mcp-custom\\dist\\github-mcp-server.exe",
  "args": ["stdio"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_***"
  }
}
```

**SOLUTION SUMMARY:**
1. ✅ **Root Cause:** Protocol version mismatch (mcp-go v0.30.0 → "2025-03-26", Claude expects "2024-11-05")
2. ✅ **Fix Applied:** Downgraded mcp-go to v0.26.0 for protocol compatibility
3. ✅ **Package Updated:** Published github-mcp-custom@1.0.18 with working version
4. ✅ **Configuration:** Direct executable path bypasses Windows NPX path issues
5. ✅ **Result:** Full GitHub MCP functionality restored

**PACKAGE PUBLISHED:**
- ✅ github-mcp-custom@1.0.17 (protocol fix attempt)
- ✅ github-mcp-custom@1.0.18 (final working version)

**NEXT:** Testing NPX configuration for standard user experience

---

## Resolved Issues

### Issue #001 - MCP Server Disconnect After Initialization
**Status:** 🟢 Resolved  
**Priority:** High  
**Created:** 2025-06-04  
**Resolved:** 2025-06-04  
**Resolution:** Protocol version compatibility fix + package update

**Final Solution:**
- Updated mcp-go from v0.30.0 to v0.26.0 for "2024-11-05" protocol compatibility
- Published github-mcp-custom@1.0.18 with working version
- Direct executable configuration works perfectly
- All 40+ GitHub MCP tools now functional

**Evidence of Resolution:**
- Server maintains stable connection
- All GitHub tools loaded successfully
- No disconnection errors in logs
- Full JSON-RPC communication working