@echo off
chcp 65001 >nul
echo ========================================
echo   GitHub 仓库配置向导
echo ========================================
echo.

REM 检查Git是否安装
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: Git 未安装或未添加到PATH
    echo 请先安装 Git 并确保已添加到系统PATH
    pause
    exit /b 1
)

echo ✅ Git 已安装
git --version
echo.

REM 设置用户信息
echo ========================================
echo   步骤 1: 设置 Git 用户信息
echo ========================================
echo.
set /p username="请输入您的 GitHub 用户名 (默认: 616399998): "
if "%username%"=="" set username=616399998

set /p email="请输入您的邮箱 (默认: 616399998@users.noreply.github.com): "
if "%email%"=="" set email=616399998@users.noreply.github.com

echo.
echo 正在配置 Git 用户信息...
git config --global user.name "%username%"
git config --global user.email "%email%"
echo ✅ 用户信息配置成功
echo   用户名: %username%
echo   邮箱: %email%
echo.

REM 切换到项目目录
cd /d "%~dp0"
echo.
echo 当前工作目录: %cd%
echo.

REM 初始化仓库
echo ========================================
echo   步骤 2: 初始化 Git 仓库
echo ========================================
echo.

if exist .git (
    echo ℹ️  Git 仓库已存在
    choice /C YN /M "是否重新初始化"
    if errorlevel 2 goto add_remote
    echo 正在重新初始化...
    rmdir /s /q .git 2>nul
)

echo 正在初始化 Git 仓库...
git init
if %errorlevel% neq 0 (
    echo ❌ 初始化失败
    pause
    exit /b 1
)
echo ✅ 仓库初始化成功
echo.

:add_remote
REM 添加远程仓库
echo ========================================
echo   步骤 3: 连接 GitHub 仓库
echo ========================================
echo.
echo 仓库地址: https://github.com/616399998/rescue-system.git
echo.

REM 移除旧的远程仓库
git remote remove origin 2>nul

REM 添加新的远程仓库
echo 正在添加远程仓库...
git remote add origin https://github.com/616399998/rescue-system.git
if %errorlevel% neq 0 (
    echo ⚠️  添加远程仓库失败，但可以继续
) else (
    echo ✅ 远程仓库添加成功
    git remote -v
)
echo.

REM 添加文件
echo ========================================
echo   步骤 4: 添加文件到暂存区
echo ========================================
echo.
echo 正在添加文件...
git add .
if %errorlevel% neq 0 (
    echo ❌ 添加文件失败
    pause
    exit /b 1
)
echo ✅ 文件添加成功
git status
echo.

REM 提交
echo ========================================
echo   步骤 5: 提交更改
echo ========================================
echo.
set /p message="请输入提交信息 (默认: 更新智能救援系统): "
if "%message%"=="" set message=更新智能救援系统

echo 正在提交...
git commit -m "%message%"
if %errorlevel% neq 0 (
    echo ⚠️  提交失败（可能是没有更改）
    choice /C YN /M "是否继续推送到 GitHub"
    if errorlevel 2 goto end
) else (
    echo ✅ 提交成功
)
echo.

REM 推送到GitHub
echo ========================================
echo   步骤 6: 推送到 GitHub
echo ========================================
echo.
echo ⚠️  重要提示:
echo   如果是首次推送，GitHub 可能会要求身份验证
echo   当提示输入密码时，请使用 Personal Access Token
echo   Token 获取地址: https://github.com/settings/tokens
echo.
echo 仓库地址: https://github.com/616399998/rescue-system
echo.
choice /C YN /M "确认推送到 GitHub"
if errorlevel 2 goto end

echo.
echo 正在设置主分支...
git branch -M main

echo.
echo 正在推送...
echo.
echo 注意: 推送可能需要几分钟时间...
echo.

git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   ✅ 推送成功！
    echo ========================================
    echo.
    echo 访问地址: https://616399998.github.io/rescue-system
    echo 仓库地址: https://github.com/616399998/rescue-system
    echo.
    echo ⏳ 注意: GitHub Pages 需要 2-3 分钟生效
    echo.
) else (
    echo.
    echo ========================================
    echo   ❌ 推送失败
    echo ========================================
    echo.
    echo 可能的原因:
    echo 1. GitHub 账号需要验证
    echo 2. 需要使用 Personal Access Token
    echo 3. 网络连接问题
    echo 4. 仓库未正确创建
    echo.
    echo.
    echo 解决方案:
    echo.
    echo 1. 获取 Personal Access Token:
    echo    访问: https://github.com/settings/tokens
    echo    点击: Generate new token (classic)
    echo    Note: rescue-system
    echo    勾选: repo (全部勾选), workflow
    echo    点击: Generate token
    echo    复制生成的 token（只显示一次）
    echo.
    echo 2. 再次推送时:
    echo    Username: 616399998
    echo    Password: (粘贴刚才的 token)
    echo.
    echo 3. 确认仓库已创建:
    echo    访问: https://github.com/616399998/rescue-system
    echo    如果不存在，请先创建仓库
    echo.
)

:end
echo.
pause
