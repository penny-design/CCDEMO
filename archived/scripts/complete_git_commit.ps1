# Complete Git Commit Script for Stage 2
Write-Host "=== Stage 2 Complete Git Commit ===" -ForegroundColor Green

# Get Git path from registry
try {
    $gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
    if ($gitRegistry) {
        $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
        Write-Host "Found Git at: $gitExe" -ForegroundColor Green
        
        # Check current status
        Write-Host "`nChecking repository status..." -ForegroundColor Cyan
        & $gitExe status
        
        # Add all modified and new files
        Write-Host "`nAdding all files to staging..." -ForegroundColor Cyan
        & $gitExe add -A
        
        # Create the stage 2 completion commit
        Write-Host "`nCreating Stage 2 completion commit..." -ForegroundColor Cyan
        $commitMessage = @"
🎯 阶段2完成：UI设计系统建设

## 主要成果
- 设计概念探索: direction_a → a1 → a2 → a3
- 设计系统构建: Design_Spec_A3.md + Style_Guide_A3.html  
- 技术债务清理: HTML结构优化、可访问性改进
- 项目文档同步: PROJECT_TASK_PLAN.md + AI_AGENT_WORK_PROTOCOL.md

## 项目状态更新
- 更新PROJECT_TASK_PLAN.md完成状态和总结
- 所有交付物验收完成
- 为阶段3工作就绪

Co-authored-by: factory-droid[bot] <138933559+factory-droid[bot]@users.noreply.github.com>
"@
        
        & $gitExe commit -m $commitMessage
        
        # Show final status
        Write-Host "`nFinal repository status:" -ForegroundColor Cyan
        & $gitExe status
        
        Write-Host "`n=== Stage 2 Git Commit Completed Successfully! ===" -ForegroundColor Green
        Write-Host "Repository is now ready for Stage 3 development." -ForegroundColor Yellow
        
    } else {
        Write-Host "Git not found in registry." -ForegroundColor Red
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
