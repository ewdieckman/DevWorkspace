function Invoke-SapsSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the Student Award Payment System SPA project.
    #>
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor      $script:TabColor.FrontEnd `
        -ClaudeAccount $script:ClaudeAccount.Work `
        -WorkingDirectory $global:Project.Saps `
        -ClaudeSession 'SAPS' `
        -IncludeDevServerPane `
        -DevServerCommand "Invoke-NpmDev -WorkingDirectory '$($global:Project.Saps)'"

}

New-Alias -Name Setup-Wra -Value Invoke-WraSetup -Force