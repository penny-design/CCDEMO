# Fix Git Encoding Issues Script
Write-Host "=== 修复Git编码问题 ===" -ForegroundColor Green

# Get Git path from registry
try {
    $gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
    if ($gitRegistry) {
        $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
        Write-Host "找到Git: $gitExe" -ForegroundColor Green
        
        # Set PowerShell to UTF-8
        [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
        $OutputEncoding = [Console]::OutputEncoding
        
        Write-Host "配置Git中文支持..." -ForegroundColor Cyan
        
        # Configure Git for proper Chinese support
        & $gitExe config --global core.quotepath false
        & $gitExe config --global gui.encoding utf-8
        & $gitExe config --global i18n.commit.encoding utf-8
        & $gitExe config --global i18n.logoutputencoding utf-8
        
        Write-Host "Git编码配置完成!" -ForegroundColor Green
        
        # Show current config
        Write-Host "`n当前Git配置:" -ForegroundColor Cyan
        & $gitExe config --global --list | Where-Object { $_ -match "encoding|quotepath" }
        
        Write-Host "`n创建修正的提交..." -ForegroundColor Cyan
        
        # Create a new commit with proper encoding
        $commitMessage = "🎯 阶段2完成：UI设计系统建设

## 主要成果
- 设计概念探索: direction_a → a1 → a2 → a3  
- 设计系统构建: Design_Spec_A3.md + Style_Guide_A3.html
- 技术债务清理: HTML结构优化、可访问性改进
- 项目文档同步: PROJECT_TASK_PLAN.md + AI_AGENT_WORK_PROTOCOL.md

## 项目状态更新
- 更新PROJECT_TASK_PLAN.md完成状态和总结
- 所有交付物验收完成
- 为阶段3工作就绪

Co-authored-by: factory-droid[bot] <138933559+factory-droid[bot]@users.noreply.github.com>"

        # Reset to the previous commit and create a new one with proper encoding
        Write-Host "重置并创建正确编码的提交..." -ForegroundColor Yellow
        
        # Add current files
        & $gitExe add .
        
        # Amend the last commit with proper encoding
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($commitMessage)
        $tempFile = [System.IO.Path]::GetTempFileName()
        [System.IO.File]::WriteAllBytes($tempFile, $bytes)
        
        & $gitExe commit --amend --file=$tempFile
        
        Remove-Item $tempFile -Force
        
        Write-Host "`n检查修复结果:" -ForegroundColor Cyan
        & $gitExe log --oneline -3
        
        Write-Host "`n=== Git编码问题修复完成! ===" -ForegroundColor Green
        
    } else {
        Write-Host "未找到Git安装" -ForegroundColor Red
    }
} catch {
    Write-Host "错误: $_" -ForegroundColor Red
}
