# Commit cleanup changes
$gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
if ($gitRegistry) {
    $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
    
    Write-Host "Adding all changes..."
    & $gitExe add .
    
    Write-Host "Creating commit for cleanup..."
    & $gitExe commit -m "🧹 Clean up root directory and archive non-primary files

- Deleted temporary test files and encoding fix scripts
- Archived git utility scripts to archived/scripts/
- Archived non-primary constraint documents to archived/documentation/
- Root directory now contains only primary project structure

Co-authored-by: factory-droid[bot] <138933559+factory-droid[bot]@users.noreply.github.com>"
    
    Write-Host "Push to remote..."
    & $gitExe push origin main
    
    Write-Host "Cleanup commit completed!"
}
