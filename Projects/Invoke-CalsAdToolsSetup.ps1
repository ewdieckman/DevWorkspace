function Invoke-CalsAdToolsSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the Visor API project.
    #>
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor      $script:TabColor.Neutral `
        -ClaudeAccount $script:ClaudeAccount.Work `
        -WorkingDirectory $global:Project.CalsAdTools `
        -ClaudeSession 'CALS ADTools' `

}

New-Alias -Name Setup-CalsAdTools -Value Invoke-CalsAdToolsSetup -Force