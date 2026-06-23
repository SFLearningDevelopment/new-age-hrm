#!/bin/bash
# ============================================================
#  AgentCore Hello World - macOS / Linux setup
#  AI Expertise for HR  -  optional capstone helper
#  Installs Node.js + AWS CLI + AgentCore CLI, configures your
#  AWS access keys for the default profile, and creates an IAM
#  role for the agent.
#
#  If this is too complex, take the help of the L&D team to set
#  your environment up. Cloud deployments can incur small charges
#  - set a billing alarm and run the cleanup step when done.
# ============================================================
echo ""
echo "=== AgentCore Hello World setup (macOS) ==="
echo ""

# --- 1. Node.js ---
if command -v node >/dev/null 2>&1; then
  echo "[OK] Node.js found: $(node --version)"
else
  if command -v brew >/dev/null 2>&1; then
    echo "[..] Installing Node.js via Homebrew..."
    brew install node
  else
    echo "[!] Please install Node.js LTS from https://nodejs.org and re-run,"
    echo "    or ask the L&D team for help."
    exit 1
  fi
fi

# --- 2. AWS CLI ---
if command -v aws >/dev/null 2>&1; then
  echo "[OK] AWS CLI found: $(aws --version)"
else
  if command -v brew >/dev/null 2>&1; then
    echo "[..] Installing AWS CLI via Homebrew..."
    brew install awscli
  else
    echo "[!] Please install the AWS CLI from https://aws.amazon.com/cli/ and re-run,"
    echo "    or ask the L&D team for help."
    exit 1
  fi
fi

# --- 3. AgentCore CLI ---
echo "[..] Installing the AgentCore CLI (npm)..."
npm install -g @aws/agentcore

# --- 4. Configure AWS credentials (default profile) ---
echo ""
echo "=== Configure your AWS access keys ==="
echo "You will be asked for your AWS Access Key ID and Secret Access Key."
echo "Create these in the AWS console: Security credentials > Create access key."
echo "NEVER share these keys with anyone."
echo "(For region, us-west-2 is a good default. Output format: json)"
echo ""
aws configure

# --- 5. Create an IAM role for the agent ---
echo ""
echo "[..] Creating an IAM execution role for AgentCore..."
cat > trust-policy.json <<'JSON'
{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"bedrock-agentcore.amazonaws.com"},"Action":"sts:AssumeRole"}]}
JSON
aws iam create-role --role-name AgentCoreHelloRole --assume-role-policy-document file://trust-policy.json 2>/dev/null \
  && echo "[OK] Role created." || echo "[i] Role may already exist - continuing."
aws iam attach-role-policy --role-name AgentCoreHelloRole --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess

echo ""
echo "[OK] Setup complete. Next, in this Terminal run:"
echo "    agentcore create hello-cloud-agent"
echo ""
echo "Then follow Step 4 onward in the course capstone."
echo ""
