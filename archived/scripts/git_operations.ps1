# Git Operations Script
Write-Host "=== Git Operations Starting ===" -ForegroundColor Green

# Try to find git.exe in common locations
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe", 
    "C:\Users\$env:USERNAME\AppData\Local\Programs\Git\bin\git.exe"
)

$gitExe = $null
foreach ($path in $gitPaths) {
    if (Test-Path $path) {
        $gitExe = $path
        break
    }
}

if (-not $gitExe) {
    # Try to find git in PATH or other locations
    $gitExe = Get-Command git -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source
}

if (-not $gitExe) {
    Write-Host "Git not found in standard locations. Checking registry..." -ForegroundColor Yellow
    
    # Check registry for Git installation
    try {
        $gitRegistry = Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
        if ($gitRegistry) {
            $gitExe = Join-Path $gitRegistry.InstallPath "bin\git.exe"
        }
    } catch {
        Write-Host "Registry check failed" -ForegroundColor Red
    }
}

if ($gitExe -and (Test-Path $gitExe)) {
    Write-Host "Found Git at: $gitExe" -ForegroundColor Green
    
    # Execute git commands
    try {
        Write-Host "Checking git status..." -ForegroundColor Cyan
        & $gitExe status
        
        Write-Host "Adding all files..." -ForegroundColor Cyan
        & $gitExe add .
        
        Write-Host "Creating commit..." -ForegroundColor Cyan
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
        
        Write-Host "Git operations completed successfully!" -ForegroundColor Green
        
    } catch {
        Write-Host "Error executing git commands: $_" -ForegroundColor Red
    }
    
} else {
    Write-Host "Git executable not found. Please install Git or add it to PATH." -ForegroundColor Red
    Write-Host "Attempting alternative approach..." -ForegroundColor Yellow
    
    # Alternative: Check if we're in a git repository and try VS Code git
    if (Test-Path ".git") {
        Write-Host "Git repository detected. You can use VS Code's Git interface:" -ForegroundColor Cyan
        Write-Host "1. Open Source Control panel (Ctrl+Shift+G)" -ForegroundColor White
        Write-Host "2. Stage all changes (+ button)" -ForegroundColor White
        Write-Host "3. Use the commit message from git_commit.bat" -ForegroundColor White
        Write-Host "4. Click Commit button" -ForegroundColor White
    }
}

Write-Host "=== Git Operations Complete ===" -ForegroundColor Green
