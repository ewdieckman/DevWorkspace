# Requires claude-work and claude-personal to be defined in the session.
# These are loaded via Scripts\Claude.ps1 in $PROFILE.
function Invoke-Claude {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet('work', 'personal')]
        [string]$Account,

        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path $_ -PathType Container })]
        [string]$WorkingDirectory,

        [Parameter()]
        [string]$ResumeSession
    )

    Set-Location $WorkingDirectory

    $claudeCmd = if ($Account -eq 'work') { 'claude-work' } else { 'claude-personal' }

    $claudeArgs = @()
    if ($PSBoundParameters.ContainsKey('ResumeSession')) {
        $claudeArgs += '--resume', $ResumeSession
    }

    & $claudeCmd @claudeArgs
}