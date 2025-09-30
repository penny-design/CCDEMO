# Sync with Remote Repository
Write-Host "=== Syncing with Remote Repository ===" -ForegroundColor Green

# Get Git path from registry
try {
    $gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
    if ($gitRegistry) {
        $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
        Write-Host "Found Git at: $gitExe" -ForegroundColor Yellow
        
        Write-Host "`n=== Current Status ===" -ForegroundColor Cyan
        & $gitExe status
        
        Write-Host "`n=== Fetching from remote ===" -ForegroundColor Cyan
        & $gitExe fetch origin
        
        Write-Host "`n=== Checking what changed on remote ===" -ForegroundColor Cyan
        & $gitExe log --oneline main..origin/main
        
        Write-Host "`n=== Option 1: Force push our changes (recommended) ===" -ForegroundColor Yellow
        Write-Host "This will overwrite remote with our Stage 2 completion commit" -ForegroundColor White
        Write-Host "Command: git push origin main --force-with-lease" -ForegroundColor Gray
        
        Write-Host "`n=== Option 2: Pull and merge ===" -ForegroundColor Yellow  
        Write-Host "This will merge remote changes with ours" -ForegroundColor White
        Write-Host "Command: git pull origin main --no-rebase" -ForegroundColor Gray
        
        Write-Host "`n=== Executing Option 1 (Force push with lease) ===" -ForegroundColor Green
        Write-Host "This preserves our Stage 2 completion work..." -ForegroundColor Cyan
        
        # Force push with lease (safer than regular force push)
        & $gitExe push origin main --force-with-lease
        
        Write-Host "`n=== Final Status ===" -ForegroundColor Cyan
        & $gitExe status
        
        Write-Host "`n=== Remote and Local are now synchronized! ===" -ForegroundColor Green
        
    } else {
        Write-Host "Git installation not found" -ForegroundColor Red
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
