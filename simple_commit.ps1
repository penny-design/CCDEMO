# Simple commit for Day 2 test environment
$gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
if ($gitRegistry) {
    $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
    
    Write-Host "Adding files..."
    & $gitExe add .
    
    Write-Host "Creating commit..."
    $commitMsg = "Add Day 2 mobile test environment and tools"
    & $gitExe commit -m $commitMsg
    
    Write-Host "Push to remote..."
    & $gitExe push origin main
    
    Write-Host "Commit completed!"
}
