# Fix Git Encoding Issues
Write-Host "=== Fixing Git Encoding Issues ===" -ForegroundColor Green

# Get Git path from registry
try {
    $gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
    if ($gitRegistry) {
        $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
        Write-Host "Found Git at: $gitExe" -ForegroundColor Green
        
        # Configure Git for proper UTF-8 support
        Write-Host "Configuring Git for UTF-8 support..." -ForegroundColor Cyan
        
        & $gitExe config --global core.quotepath false
        & $gitExe config --global gui.encoding utf-8
        & $gitExe config --global i18n.commit.encoding utf-8
        & $gitExe config --global i18n.logoutputencoding utf-8
        & $gitExe config --global core.autocrlf false
        
        Write-Host "Git encoding configuration completed!" -ForegroundColor Green
        
        # Show current config
        Write-Host "`nCurrent Git configuration:" -ForegroundColor Cyan
        & $gitExe config --global --list | Where-Object { $_ -match "encoding|quotepath|autocrlf" }
        
        # Create a simple English commit message first
        Write-Host "`nCreating corrected commit..." -ForegroundColor Cyan
        
        $simpleMessage = "Stage 2 Complete: UI Design System Development

## Main Achievements
- Design concept exploration: direction_a -> a1 -> a2 -> a3
- Design system construction: Design_Spec_A3.md + Style_Guide_A3.html
- Technical debt cleanup: HTML structure optimization, accessibility improvements
- Project documentation sync: PROJECT_TASK_PLAN.md + AI_AGENT_WORK_PROTOCOL.md

## Project Status Update
- Updated PROJECT_TASK_PLAN.md completion status and summary
- All deliverables verified and completed
- Ready for Stage 3 development

Co-authored-by: factory-droid[bot] <138933559+factory-droid[bot]@users.noreply.github.com>"

        # Add current files
        & $gitExe add .
        
        # Amend the last commit with proper encoding
        & $gitExe commit --amend -m $simpleMessage
        
        Write-Host "`nChecking result:" -ForegroundColor Cyan
        & $gitExe log --oneline -3
        
        Write-Host "`n=== Git encoding fix completed! ===" -ForegroundColor Green
        
    } else {
        Write-Host "Git installation not found" -ForegroundColor Red
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
