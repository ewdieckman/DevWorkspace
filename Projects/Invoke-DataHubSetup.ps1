function Invoke-DataHubSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the DataHub SPA project.
    #>
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor      $script:TabColor.FrontEnd `
        -ClaudeAccount $script:ClaudeAccount.Work `
        -WorkingDirectory $global:Project.DataHub `
        -ClaudeSession 'DataHub' `
        -IncludeDevServerPane `
        -DevServerCommand "Invoke-NpmDev -WorkingDirectory '$($global:Project.DataHub)'"

}

New-Alias -Name Setup-DataHub -Value Invoke-DataHubSetup -Force