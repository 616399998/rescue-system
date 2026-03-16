@echo off
echo ====================================
echo   智能救援系统 - 本地服务器
echo ====================================
echo.
echo 服务器启动中...
echo 请在浏览器中访问: http://localhost:8080
echo.
echo 按 Ctrl+C 停止服务器
echo ====================================
echo.

cd /d "%~dp0"
if exist "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" (
    echo 使用 PowerShell 启动服务器...
    powershell -Command "cd '%~dp0'; python -m http.server 8080 2>&1"
) else (
    echo Python 服务器启动失败
    echo 请安装 Python 或使用 VS Code Live Server
    pause
)
