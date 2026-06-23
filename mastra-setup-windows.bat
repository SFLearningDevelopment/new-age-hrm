@echo off
REM ============================================================
REM  Mastra Hello World - Windows setup
REM  AI Expertise for HR  -  optional capstone helper
REM  This installs Node.js (if needed) and prepares your tools.
REM  If this is too complex, take the help of the L&D team to
REM  set your environment up.
REM ============================================================
echo.
echo === Mastra Hello World setup (Windows) ===
echo.

REM --- 1. Check for Node.js ---
where node >nul 2>nul
if %errorlevel%==0 (
  echo [OK] Node.js is already installed:
  node --version
) else (
  echo [..] Node.js not found. Installing via winget...
  winget install -e --id OpenJS.NodeJS.LTS
  echo.
  echo [!] Please CLOSE this window and run this script again
  echo     so the new Node.js is picked up.
  pause
  exit /b
)

echo.
echo [OK] Your computer is ready to build a Mastra agent.
echo.
echo Next, in this window run:
echo     npm create mastra@latest hello-agent
echo.
echo Then follow Step 2 onward in the course capstone.
echo.
pause
