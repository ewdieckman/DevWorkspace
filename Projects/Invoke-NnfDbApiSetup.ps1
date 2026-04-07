function Invoke-NnfDbApiSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the NNFDB API project.
    #>
    [CmdletBinding()]
    param()

    Invoke-AppDevSetup `
        -TabColor      $script:TabColor.BackEnd `
        -ClaudeAccount $script:ClaudeAccount.Personal `
        -WorkingDirectory $global:Project.NnfDbApi `
        -ClaudeSession 'NeverNotDB API' `
        -IncludeDevServerPane `
        -DevServerCommand "Invoke-DotnetWatch -WorkingDirectory '$($global:Project.NnfDbApi)' -Project 'src\api\Api.csproj'"
}

New-Alias -Name Setup-NnfDbApi -Value Invoke-NnfDbApiSetup -Force