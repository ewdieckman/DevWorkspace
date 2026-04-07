# DevWorkspace.psm1
# Barrel file — dot-sources all config and functions automatically.
# Drop a new .ps1 into Config\ or Functions\ and it will be picked up on next import.

$private:moduleRoot = $PSScriptRoot

# Load shared variables first so functions can reference them
foreach ($config in (Get-ChildItem -Path "$moduleRoot\Config\*.ps1" -ErrorAction SilentlyContinue)) {
    . $config.FullName
}

# Load all function definitions
foreach ($function in (Get-ChildItem -Path "$moduleRoot\Functions\*.ps1" -ErrorAction SilentlyContinue)) {
    . $function.FullName
}

# Load all project setup commands
foreach ($project in (Get-ChildItem -Path "$moduleRoot\Projects\*.ps1" -ErrorAction SilentlyContinue)) {
    . $project.FullName
}