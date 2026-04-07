function Get-DevWorkspaceAliases {
    <#
    .SYNOPSIS
        Lists all aliases exported by the DevWorkspace module.
    #>
    [CmdletBinding()]
    param()

    Get-Alias | Where-Object { $_.Source -eq 'DevWorkspace' } |
    Select-Object Name, Definition |
    Sort-Object Name |
    Format-Table -AutoSize
}

New-Alias -Name List-DevAliases -Value Get-DevWorkspaceAliases -Force