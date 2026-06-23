#!/bin/bash
# ============================================================
#  Mastra Hello World - macOS / Linux setup
#  AI Expertise for HR  -  optional capstone helper
#  Installs Node.js (if needed) and prepares your tools.
#  If this is too complex, take the help of the L&D team to
#  set your environment up.
# ============================================================
echo ""
echo "=== Mastra Hello World setup (macOS) ==="
echo ""

# --- 1. Check for Node.js ---
if command -v node >/dev/null 2>&1; then
  echo "[OK] Node.js is already installed: $(node --version)"
else
  echo "[..] Node.js not found."
  if command -v brew >/dev/null 2>&1; then
    echo "[..] Installing Node.js via Homebrew..."
    brew install node
  else
    echo "[!] Homebrew is not installed."
    echo "    Easiest option: download the Node.js LTS installer from"
    echo "    https://nodejs.org and run it, then re-run this script."
    echo "    Or ask the L&D team for help."
    exit 1
  fi
fi

echo ""
echo "[OK] Your computer is ready to build a Mastra agent."
echo ""
echo "Next, in this Terminal run:"
echo "    npm create mastra@latest hello-agent"
echo ""
echo "Then follow Step 2 onward in the course capstone."
echo ""
