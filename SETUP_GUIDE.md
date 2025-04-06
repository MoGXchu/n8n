# n8n Development Setup Guide

This guide provides comprehensive instructions for setting up the n8n development environment. Follow these steps to get n8n running locally for development or testing purposes.

## Prerequisites

Before starting, make sure you have the following installed on your system:

1. **Node.js** (version 20.15 or newer)
2. **pnpm** (version 10.2.1 or newer)
   - Recommended to install via corepack: `corepack enable` followed by `corepack prepare pnpm@latest --activate`
3. **Build tools** depending on your operating system:
   - **Debian/Ubuntu**: `apt-get install -y build-essential python`
   - **CentOS**: `yum install gcc gcc-c++ make`
   - **Windows**: `npm add -g windows-build-tools`
   - **macOS**: No additional packages required

## Step 1: Clone the Repository

```bash
git clone https://github.com/MoGXchu/n8n.git
cd n8n
```

## Step 2: Set Up Dependencies

Install all dependencies and link all modules together:

```bash
pnpm install
```

This may take a few minutes as it installs dependencies for all packages in the monorepo.

## Step 3: Build the Code

Build all packages:

```bash
pnpm build
```

## Step 4: Start n8n

You can start n8n in different modes:

### Development Mode (with auto-reload)

```bash
pnpm dev
```

This will start n8n in development mode, which automatically rebuilds code, restarts the backend, and refreshes the frontend when you make changes.

### Production Mode

```bash
pnpm start
```

### With Tunnel (for webhook testing)

```bash
pnpm start:tunnel
```

## Accessing n8n

Once started, access the n8n editor at:

```
http://localhost:5678
```

Default credentials:
- Email: `admin@example.com`
- Password: `password`

## Development Workflow

1. Run n8n in development mode:
   ```bash
   pnpm dev
   ```

2. Make changes to the code

3. Test your changes

4. Run tests:
   ```bash
   pnpm test
   ```

## Available Scripts

- `pnpm build`: Build all packages
- `pnpm dev`: Start n8n in development mode
- `pnpm start`: Start n8n in production mode
- `pnpm test`: Run all tests
- `pnpm clean`: Clean build artifacts
- `pnpm typecheck`: Run TypeScript type checking
- `pnpm lint`: Lint all code
- `pnpm lintfix`: Lint and fix code issues

## Directory Structure

- `/packages/cli`: CLI code to run front & backend
- `/packages/core`: Core workflow execution code
- `/packages/frontend/editor-ui`: Vue frontend workflow editor
- `/packages/nodes-base`: Base n8n nodes
- `/packages/workflow`: Workflow code shared between front & backend

## Troubleshooting

1. **Port conflicts**
   - If port 5678 is already in use, you can change it using the `--port` flag or `N8N_PORT` environment variable

2. **Node.js version issues**
   - Make sure you're using Node.js 20.15 or newer. Check with `node -v`

3. **Dependencies installation problems**
   - Try clearing the cache: `pnpm store prune` and reinstall

4. **Build errors**
   - Run `pnpm clean` and then `pnpm build` again

5. **Reset local development setup**
   - Run `pnpm reset` to completely reset your development environment

## Additional Resources

- [Full Documentation](https://docs.n8n.io)
- [Contributing Guide](CONTRIBUTING.md)
- [Community Forum](https://community.n8n.io)
