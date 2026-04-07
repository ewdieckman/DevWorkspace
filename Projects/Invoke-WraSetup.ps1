function Invoke-WraSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the Workday Role Access SPA project.
    #>
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor      $script:TabColor.FrontEnd `
        -ClaudeAccount $script:ClaudeAccount.Work `
        -WorkingDirectory $global:Project.Wra `
        -ClaudeSession 'WRA' `
        -IncludeDevServerPane `
        -DevServerCommand "Invoke-NpmDev -WorkingDirectory '$($global:Project.Wra)'"

}

New-Alias -Name Setup-Wra -Value Invoke-WraSetup -Force