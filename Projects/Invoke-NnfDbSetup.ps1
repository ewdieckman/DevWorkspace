function Invoke-NnfDbSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the NNFDB API and SPA projects.
    #>
    [CmdletBinding()]
    param()

    Setup-NnfDbSpa
    Setup-NnfDbApi

}

New-Alias -Name Setup-NnfDb -Value Invoke-NnfDbSetup -Force