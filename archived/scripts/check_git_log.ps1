# Check Git Log and Status
Write-Host "=== Git Repository Check ===" -ForegroundColor Green

# Get Git path from registry
try {
    $gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
    if ($gitRegistry) {
        $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
        Write-Host "Found Git at: $gitExe" -ForegroundColor Yellow
        
        Write-Host "`n=== Current Git Status ===" -ForegroundColor Cyan
        & $gitExe status
        
        Write-Host "`n=== Git Log (Last 10 commits) ===" -ForegroundColor Cyan
        & $gitExe log --oneline -10
        
        Write-Host "`n=== Remote Repository Info ===" -ForegroundColor Cyan
        & $gitExe remote -v
        
        Write-Host "`n=== Branch Information ===" -ForegroundColor Cyan
        & $gitExe branch -a
        
        Write-Host "`n=== Latest Commit Details ===" -ForegroundColor Cyan
        & $gitExe show --stat HEAD
        
        Write-Host "`n=== Check if ahead/behind remote ===" -ForegroundColor Cyan
        & $gitExe status -uno
        
    } else {
        Write-Host "Git installation not found in registry" -ForegroundColor Red
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
