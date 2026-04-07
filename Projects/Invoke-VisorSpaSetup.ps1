function Invoke-VisorSpaSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the Visor SPA project.
    #>
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor      $script:TabColor.FrontEnd `
        -ClaudeAccount $script:ClaudeAccount.Work `
        -WorkingDirectory $global:Project.VisorSpa `
        -ClaudeSession 'VISOR SPA' `
        -IncludeDevServerPane `
        -DevServerCommand "Invoke-NpmDev -WorkingDirectory '$($global:Project.VisorSpa)'"

}

New-Alias -Name Setup-VisorSpa -Value Invoke-VisorSpaSetup -Force