function Invoke-NnfDbSpaSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the NNFDB SPA project.
    #>
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor      $script:TabColor.FrontEnd `
        -ClaudeAccount $script:ClaudeAccount.Personal `
        -WorkingDirectory $global:Project.NnfDbSpa `
        -ClaudeSession 'NeverNotDB SPA' `
        -IncludeDevServerPane `
        -DevServerCommand "Invoke-NpmDev -WorkingDirectory '$($global:Project.NnfDbSpa)'"

}

New-Alias -Name Setup-NnfDbSpa -Value Invoke-NnfDbSpaSetup -Force