function Invoke-VisorApiSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the Visor API project.
    #>
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor      $script:TabColor.BackEnd `
        -ClaudeAccount $script:ClaudeAccount.Work `
        -WorkingDirectory $global:Project.VisorApi `
        -ClaudeSession 'VISOR API' `
        -IncludeDevServerPane `
        -DevServerCommand "Invoke-DotnetWatch -WorkingDirectory '$($global:Project.VisorApi)' -Project 'src\api\Api.csproj'"
}

New-Alias -Name Setup-VisorApi -Value Invoke-VisorApiSetup -Force