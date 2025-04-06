#!/bin/bash

# n8n Setup Script
# This script helps automate the setup process for n8n development

echo "====== n8n Setup Script ======"
echo "This script will help you set up n8n for local development."
echo ""

# Check for Node.js
echo "Checking Node.js installation..."
if command -v node > /dev/null; then
  NODE_VERSION=$(node -v)
  echo "✅ Node.js is installed: $NODE_VERSION"
  
  # Check Node.js version
  NODE_VERSION_MAJOR=$(echo $NODE_VERSION | cut -d. -f1 | sed 's/v//')
  if [ "$NODE_VERSION_MAJOR" -lt 20 ]; then
    echo "❌ Node.js version is less than 20.15. Please update Node.js."
    echo "   You can use nvm to install a newer version:"
    echo "   nvm install 20.15"
    exit 1
  fi
else
  echo "❌ Node.js is not installed. Please install Node.js 20.15 or newer."
  exit 1
fi

# Check for pnpm
echo "Checking pnpm installation..."
if command -v pnpm > /dev/null; then
  PNPM_VERSION=$(pnpm -v)
  echo "✅ pnpm is installed: $PNPM_VERSION"
else
  echo "pnpm is not installed. Would you like to install it? (y/n)"
  read install_pnpm
  if [ "$install_pnpm" = "y" ]; then
    echo "Installing pnpm using corepack..."
    corepack enable
    corepack prepare pnpm@latest --activate
    echo "✅ pnpm installed successfully"
  else
    echo "❌ pnpm is required for n8n development. Please install it manually."
    exit 1
  fi
fi

# Check for essential build tools
echo "Checking build tools..."
if [ "$(uname)" = "Linux" ]; then
  echo "Detected Linux system. Checking for build-essential..."
  if command -v gcc > /dev/null; then
    echo "✅ gcc found, build tools appear to be installed"
  else
    echo "Would you like to install build tools? (y/n)"
    read install_build_tools
    if [ "$install_build_tools" = "y" ]; then
      echo "Detecting package manager..."
      if command -v apt > /dev/null; then
        echo "Installing build-essential with apt..."
        sudo apt-get update
        sudo apt-get install -y build-essential python
      elif command -v yum > /dev/null; then
        echo "Installing build tools with yum..."
        sudo yum install -y gcc gcc-c++ make
      else
        echo "❌ Unsupported package manager. Please install build tools manually."
      fi
    else
      echo "⚠️ Build tools are required for some n8n dependencies."
    fi
  fi
elif [ "$(uname)" = "Darwin" ]; then
  echo "✅ macOS detected. No additional build tools required."
elif [ "$(uname -s)" = "MINGW"* ] || [ "$(uname -s)" = "MSYS"* ] || [ "$(uname -s)" = "CYGWIN"* ]; then
  echo "Windows detected. Build tools might be required."
  echo "If you encounter build errors, run: npm add -g windows-build-tools"
fi

# Install dependencies
echo ""
echo "Installing n8n dependencies..."
pnpm install
if [ $? -ne 0 ]; then
  echo "❌ Error installing dependencies."
  exit 1
else
  echo "✅ Dependencies installed successfully"
fi

# Build the project
echo ""
echo "Building n8n..."
pnpm build
if [ $? -ne 0 ]; then
  echo "❌ Error building n8n."
  exit 1
else
  echo "✅ n8n built successfully"
fi

echo ""
echo "====== Setup Complete! ======"
echo ""
echo "You can now start n8n in development mode with:"
echo "pnpm dev"
echo ""
echo "Access the editor at: http://localhost:5678"
echo ""
echo "For more information, see the SETUP_GUIDE.md file."
