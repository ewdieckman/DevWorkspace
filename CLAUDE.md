# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Module Does

**DevWorkspace** is a PowerShell module (requires PS 7.0+) that creates pre-configured multi-pane Windows Terminal layouts for developer projects. A single command like `Setup-VisorSpa` opens a tab with:
- Left pane: Claude Code session (resumed if named session exists)
- Right pane: Interactive shell at the project directory
- Bottom-right pane (optional): Dev server (npm/dotnet)

## Loading the Module

No build step — import directly or place the module folder under a path in `$PSModulePath` for auto-loading.

## Common Commands

```powershell
# List all exported aliases
Get-DevWorkspaceAliases   # alias: List-DevAliases

# Launch a specific project workspace
Setup-VisorSpa
Setup-VisorApi
Setup-NnfDb               # launches both SPA and API setups
Setup-NnfDbSpa
Setup-NnfDbApi
Setup-DataHub
Setup-Saps
Setup-Wra
Setup-CalsAdTools
```

## Architecture

The module uses a **barrel loader pattern**: `DevWorkspace.psm1` dot-sources everything in `Config/`, `Functions/`, and `Projects/` — drop a `.ps1` file in the right folder and it's automatically included.

### Core Flow

1. `Config/Workspace.Config.ps1` — defines `$TabColors`, `$ClaudeAccounts`, and `$ProjectPaths` (all paths built from `$global:CodeHome` for machine-portability)
2. `Functions/Invoke-AppDevSetup.ps1` — the central orchestrator; calls `wt` CLI to create the multi-pane terminal layout
3. `Functions/Invoke-Claude.ps1` — wraps the `claude-work`/`claude-personal` CLI aliases
4. `Functions/Invoke-DevServer.ps1` — `Invoke-NpmDev` and `Invoke-DotnetWatch` helpers
5. `Projects/*.ps1` — one file per project; each calls `Invoke-AppDevSetup` with hardcoded tab color, account, path, and dev server command

### Adding a New Project

1. Add the project path to `Config/Workspace.Config.ps1` under `$ProjectPaths`
2. Create `Projects/Invoke-<ProjectName>Setup.ps1` following the existing pattern
3. The function is auto-loaded on next module import

## Runtime Dependencies

- `$global:CodeHome` must be defined in the PowerShell profile (all project paths are relative to it)
- `claude-work` and `claude-personal` CLI aliases must be defined in the profile
- Windows Terminal (`wt.exe`) must be in PATH
- Node.js (`npm`) for frontend projects; .NET SDK (`dotnet`) for backend projects
