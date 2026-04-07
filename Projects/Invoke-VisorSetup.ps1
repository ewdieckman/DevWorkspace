function Invoke-VisorSetup {
    <#
    .SYNOPSIS
        Opens a Windows Terminal dev layout for the Visor API and SPA projects.
    #>
    [CmdletBinding()]
    param()

    Setup-VisorSpa
    Setup-VisorApi

}

New-Alias -Name Setup-Visor -Value Invoke-VisorSetup -Force