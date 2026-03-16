@echo off
chcp 65001 >nul
cd /d "E:\AI\救援"
echo Running Node.js script...
node push-github.js
if errorlevel 1 (
    echo Failed!
) else (
    echo Done!
)
pause