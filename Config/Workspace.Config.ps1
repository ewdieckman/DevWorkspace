# Workspace.Config.ps1
# Shared project paths, tab colors, and Claude account identifiers.
# Edit this file to add new projects. Variables are module-scoped and
# available to all functions loaded by DevWorkspace.psm1.

#region Tab Colors
$script:TabColor = @{
    FrontEnd = '#5495f3'
    BackEnd  = '#04774a'
    DevOps   = '#ff8c00'
    Data     = '#c71585'
    Neutral  = '#5D5D5D'
}
#endregion

#region Claude Accounts
$script:ClaudeAccount = @{
    Work     = 'work'
    Personal = 'personal'
}
#endregion

#region Project Paths
# $global:CodeHome is defined per-machine in $PROFILE, e.g.:
#   $global:CodeHome = 'D:\Code'
# All project paths are built relative to it so this config is machine-agnostic.
$global:Project = @{
    CalsAdTools = Join-Path $global:CodeHome 'git.doit.wisc.edu\cals\infrastructure\active-directory\cals-adtools'
    DataHub     = Join-Path $global:CodeHome 'git.doit.wisc.edu\cals\appdev\projects\datahub\frontend'
    NnfDbApi    = Join-Path $global:CodeHome 'github.com\ewdieckman\nevernotdb-api'
    NnfDbSpa    = Join-Path $global:CodeHome 'github.com\ewdieckman\nevernotdb-spa'
    Saps        = Join-Path $global:CodeHome 'git.doit.wisc.edu\cals\appdev\projects\saps\frontend'
    VisorSpa    = Join-Path $global:CodeHome 'git.doit.wisc.edu\cals\appdev\projects\visor\spa'
    VisorApi    = Join-Path $global:CodeHome 'git.doit.wisc.edu\cals\appdev\projects\visor\api'
    Wra         = Join-Path $global:CodeHome 'git.doit.wisc.edu\cals\appdev\projects\wra\frontend'
}
#endregion