@echo off
REM ============================================================
REM  AgentCore Hello World - Windows setup
REM  AI Expertise for HR  -  optional capstone helper
REM  Installs Node.js + AWS CLI + AgentCore CLI, configures your
REM  AWS access keys for the default profile, and creates an IAM
REM  role for the agent.
REM
REM  If this is too complex, take the help of the L&D team to set
REM  your environment up. Cloud deployments can incur small
REM  charges - set a billing alarm and run the cleanup step when
REM  you are done.
REM ============================================================
echo.
echo === AgentCore Hello World setup (Windows) ===
echo.

REM --- 1. Node.js ---
where node >nul 2>nul
if %errorlevel%==0 (
  echo [OK] Node.js found: 
  node --version
) else (
  echo [..] Installing Node.js LTS via winget...
  winget install -e --id OpenJS.NodeJS.LTS
  echo [!] Close this window and run the script again to pick up Node.js.
  pause
  exit /b
)

REM --- 2. AWS CLI ---
where aws >nul 2>nul
if %errorlevel%==0 (
  echo [OK] AWS CLI found:
  aws --version
) else (
  echo [..] Installing AWS CLI via winget...
  winget install -e --id Amazon.AWSCLI
  echo [!] Close this window and run the script again to pick up the AWS CLI.
  pause
  exit /b
)

REM --- 3. AgentCore CLI ---
echo [..] Installing the AgentCore CLI (npm)...
call npm install -g @aws/agentcore

REM --- 4. Configure AWS credentials (default profile) ---
echo.
echo === Configure your AWS access keys ===
echo You will be asked for your AWS Access Key ID and Secret Access Key.
echo Create these in the AWS console: Security credentials  ^>  Create access key.
echo NEVER share these keys with anyone.
echo (For region, us-west-2 is a good default. Output format: json)
echo.
call aws configure

REM --- 5. Create an IAM role for the agent ---
echo.
echo [..] Creating an IAM execution role for AgentCore...
echo {"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"bedrock-agentcore.amazonaws.com"},"Action":"sts:AssumeRole"}]} > trust-policy.json
aws iam create-role --role-name AgentCoreHelloRole --assume-role-policy-document file://trust-policy.json
aws iam attach-role-policy --role-name AgentCoreHelloRole --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
echo [OK] Role 'AgentCoreHelloRole' created (or already exists).
echo.
echo [OK] Setup complete. Next, in this window run:
echo     agentcore create hello-cloud-agent
echo.
echo Then follow Step 4 onward in the course capstone.
echo.
pause
