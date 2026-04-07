function Invoke-NpmDev {
    <#
    .SYNOPSIS
        Navigates to a project directory and runs 'npm run dev'.
    .PARAMETER WorkingDirectory
        The project directory containing package.json.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path $_ -PathType Container })]
        [string] $WorkingDirectory
    )

    Set-Location $WorkingDirectory
    npm run dev
}

function Invoke-DotnetWatch {
    <#
    .SYNOPSIS
        Navigates to a project directory and runs 'dotnet watch'.
    .PARAMETER WorkingDirectory
        The project directory containing the .csproj file.
    .PARAMETER Project
        Optional path to a specific .csproj file. If omitted, dotnet watch
        will discover the project automatically.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path $_ -PathType Container })]
        [string] $WorkingDirectory,

        [Parameter()]
        [string] $Project
    )

    Set-Location $WorkingDirectory

    $watchArgs = @('watch')
    if ($PSBoundParameters.ContainsKey('Project')) {
        $watchArgs += '--project', $Project
    }

    dotnet @watchArgs
}