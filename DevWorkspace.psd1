# DevWorkspace.psd1
@{
    RootModule        = 'DevWorkspace.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'dbe19c9f-aa2d-4ec5-a315-af8d825e40cd'   # replace: [guid]::NewGuid()
    Author            = 'Eric Dieckman'
    Description       = 'Shared dev workspace setup functions and config for Windows Terminal layouts.'
    PowerShellVersion = '7.0'

    # Populated automatically via the barrel — no need to list functions manually
    FunctionsToExport = '*'
    AliasesToExport   = '*'
    VariablesToExport = '*'
}