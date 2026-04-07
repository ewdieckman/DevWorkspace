# DevWorkspace

A PowerShell module for launching pre-configured multi-pane Windows Terminal workspaces for developer projects. A single command opens a new terminal tab with a Claude Code session, an interactive shell, and an optional dev server pane — all pointed at the right project directory.

## Requirements

- PowerShell 7.0+
- [Windows Terminal](https://aka.ms/terminal) (`wt.exe` in PATH)
- Claude Code CLI (see below)

---

## Workstation Setup

### 1. Clone the repository

Clone this repo into a folder on your PowerShell module path. To see your module paths:

```powershell
$env:PSModulePath -split ';'
```

Place it so the folder is named `DevWorkspace` under one of those paths, e.g.:

```
Documents\PowerShell\Modules\DevWorkspace\
```

### 2. Configure your PowerShell profile

Open your profile file:

```powershell
notepad $PROFILE
```

Add the following, adjusting the path to match your machine:

```powershell
# Root directory where all your source repos are cloned
$global:CodeHome = 'D:\Code'

# Claude Code account aliases
# These must point to the claude CLI using the correct account
function claude-work     { claude --account work @args }
function claude-personal { claude --account personal @args }
```

> `$global:CodeHome` is required. All project paths in the module are built relative to it, so the config works across machines without changes.

### 3. Import the module

Add this to your profile to auto-load the module in every session:

```powershell
Import-Module DevWorkspace
```

Or import manually when needed:

```powershell
Import-Module DevWorkspace
```

---

## Using `$global:Project`

When the module loads, it populates `$global:Project` with paths to all configured projects. You can use this anywhere in your shell:

```powershell
# Navigate to a project
cd $global:Project.VisorApi
cd $global:Project.NnfDbSpa

# Open in VS Code
code $global:Project.DataHub

# Pass to a command
git -C $global:Project.VisorSpa log --oneline -10
```

---

## Launching Workspaces

Each project has a `Setup-*` alias that opens a new Windows Terminal tab with the full dev layout:

```powershell
Setup-VisorSpa        # Vue SPA — includes npm dev server pane
Setup-VisorApi        # .NET API — includes dotnet watch pane
Setup-NnfDb           # Launches both NnfDbSpa and NnfDbApi setups
Setup-NnfDbSpa
Setup-NnfDbApi
Setup-DataHub
Setup-Saps
Setup-Wra
Setup-CalsAdTools     # No dev server pane (editor + shell only)
```

Each command opens a tab with:

| Pane | Content |
|------|---------|
| Left | Claude Code (resumes named session if it exists) |
| Top-right | Interactive shell at the project directory |
| Bottom-right | Dev server (`npm run dev` or `dotnet watch`) — if configured |

---

## Adding a New Project

### Step 1 — Add the path to `Config\Workspace.Config.ps1`

```powershell
$global:Project = @{
    # ... existing entries ...
    MyApp = Join-Path $global:CodeHome 'github.com\myorg\my-app'
}
```

### Step 2 — Create `Projects\Invoke-MyAppSetup.ps1`

```powershell
function Invoke-MyAppSetup {
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor         $script:TabColor.FrontEnd `
        -ClaudeAccount    $script:ClaudeAccount.Work `
        -WorkingDirectory $global:Project.MyApp `
        -ClaudeSession    'My App' `
        -IncludeDevServerPane `
        -DevServerCommand "Invoke-NpmDev -WorkingDirectory '$($global:Project.MyApp)'"
}

New-Alias -Name Setup-MyApp -Value Invoke-MyAppSetup -Force
```

Omit `-IncludeDevServerPane` and `-DevServerCommand` for projects with no dev server.

No further registration is needed — the barrel loader picks up any `.ps1` file in `Projects\` automatically.

---

## Configuration Reference

### Tab Colors (`$script:TabColor`)

| Key | Color | Intended Use |
|-----|-------|--------------|
| `FrontEnd` | Blue `#5495f3` | JavaScript/TypeScript SPAs |
| `BackEnd` | Green `#04774a` | APIs and server-side projects |
| `DevOps` | Orange `#ff8c00` | Infrastructure, pipelines |
| `Data` | Magenta `#c71585` | Data pipelines, databases |
| `Neutral` | Gray `#5D5D5D` | Tooling, scripts, misc |

### Claude Accounts (`$script:ClaudeAccount`)

| Key | Value |
|-----|-------|
| `Work` | `'work'` |
| `Personal` | `'personal'` |

### `Invoke-AppDevSetup` Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `-TabColor` | Yes | Hex color for the terminal tab (e.g. `'#FF6600'`) |
| `-ClaudeAccount` | Yes | `'work'` or `'personal'` |
| `-WorkingDirectory` | Yes | Full path to the project root |
| `-ClaudeSession` | Yes | Session name to resume in Claude Code |
| `-IncludeDevServerPane` | No | Switch — adds a third pane for the dev server |
| `-DevServerCommand` | No | Command string to run in the dev server pane |
| `-SplitPauseMs` | No | Delay (ms) between pane creation — default `500` |

### Dev Server Helpers

**`Invoke-NpmDev`** — navigates to a directory and runs `npm run dev`

```powershell
Invoke-NpmDev -WorkingDirectory $global:Project.VisorSpa
```

**`Invoke-DotnetWatch`** — runs `dotnet watch`, with optional project file

```powershell
Invoke-DotnetWatch -WorkingDirectory $global:Project.VisorApi -Project 'src\api\Api.csproj'
Invoke-DotnetWatch -WorkingDirectory $global:Project.MyApi    # auto-discovers .csproj
```
