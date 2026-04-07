function Invoke-AppDevSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal tab with a split-pane dev layout for an application project.

    .DESCRIPTION
        Creates a new Windows Terminal tab with a specified color, launches Claude Code
        in the left pane via Invoke-Claude, and opens two additional split panes (vertical
        then horizontal) set to the project working directory. Optionally adds a third
        pane for a dev server via -IncludeDevServerPane.

    .PARAMETER TabColor
        The hex color string for the terminal tab (e.g. '#FF6600').

    .PARAMETER ClaudeAccount
        The account identifier passed to Invoke-Claude (e.g. 'work' or 'personal').

    .PARAMETER WorkingDirectory
        The full path to the project working directory.

    .PARAMETER ClaudeSession
        The Claude session name to resume, passed to Invoke-Claude's -ResumeSession parameter.

    .PARAMETER DevServerCommand
        Optional command string to run in the dev server pane (pane 3). If omitted,
        the pane opens at WorkingDirectory with no command. Only used when -IncludeDevServerPane
        is specified. Example: "Invoke-NpmDev -WorkingDirectory 'C:\Dev\app'"

    .PARAMETER IncludeDevServerPane
        If specified, adds a third pane (horizontal split of the right pane) for running
        a dev server. Omit to get a two-pane layout.

    .PARAMETER SplitPauseMs
        Milliseconds to wait between wt commands. Defaults to 500.

    .EXAMPLE
        Invoke-AppDevSetup -TabColor '#FF6600' -ClaudeAccount 'work' -WorkingDirectory 'C:\Projects\MyApp' -ClaudeSession 'My App'

    .EXAMPLE
        Invoke-AppDevSetup -TabColor '#0078D4' -ClaudeAccount 'personal' -WorkingDirectory $env:USERPROFILE\src\visor-spa -ClaudeSession 'VISOR SPA' -SplitPauseMs 750
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidatePattern('^#[0-9A-Fa-f]{6}$')]
        [string] $TabColor,

        [Parameter(Mandatory)]
        [string] $ClaudeAccount,

        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path $_ -PathType Container })]
        [string] $WorkingDirectory,

        [Parameter(Mandatory)]
        [string] $ClaudeSession,

        [Parameter()]
        [string] $DevServerCommand,

        [Parameter()]
        [switch] $IncludeDevServerPane,        

        [Parameter()]
        [int] $SplitPauseMs = 500
    )

    # Normalize path (removes trailing slashes, etc.)
    $WorkingDirectory = (Resolve-Path $WorkingDirectory).Path

    # Pane 1 � New tab: Claude Code session (left pane)
    wt --window 0 new-tab --tabColor $TabColor -p "PowerShell" -- pwsh -NoExit -Command  "Invoke-Claude -Account '$ClaudeAccount' -WorkingDirectory '$WorkingDirectory' -ResumeSession '$ClaudeSession'"

    Start-Sleep -Milliseconds $SplitPauseMs

    # Pane 2 Vertical split (right pane): interactive working directory shell
    wt --window 0 split-pane -V --tabColor $TabColor -p "PowerShell" -- pwsh -NoExit -Command "Set-Location '$WorkingDirectory'"

    # Pane 3  Horizontal split of the right pane: dev server (optionsl)
    if ($IncludeDevServerPane) {

        Start-Sleep -Milliseconds $SplitPauseMs

        $pane3Command = if ($PSBoundParameters.ContainsKey('DevServerCommand')) {
            $DevServerCommand
        }
        else {
            "Set-Location '$WorkingDirectory'"
        }        

        wt --window 0 split-pane -H --tabColor $TabColor -p "PowerShell" -- pwsh -NoExit -Command "$pane3Command"
    }

    Start-Sleep -Milliseconds $SplitPauseMs

    wt --window 0 focus-pane --target 0
}