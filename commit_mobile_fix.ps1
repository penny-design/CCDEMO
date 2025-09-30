# Commit mobile layout fixes
$gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
if ($gitRegistry) {
    $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
    
    Write-Host "Adding mobile layout fixes..."
    & $gitExe add .
    
    Write-Host "Creating commit..."
    $commitMsg = "Fix mobile layout spacing issues in P1 prototype"
    & $gitExe commit -m $commitMsg
    
    Write-Host "Push to remote..."
    & $gitExe push origin main
    
    Write-Host "Mobile layout fixes committed!"
}
