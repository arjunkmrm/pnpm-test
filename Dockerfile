FROM node:22-slim

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Install pnpm and configure to allow build scripts and hoist all dependencies
RUN npm install -g pnpm && \
    echo "shamefully-hoist=true" >> .npmrc

# Install dependencies
ENV CI=true
RUN pnpm install --frozen-lockfile

# Build the server using Smithery CLI
RUN npx -y @smithery/cli build -o .smithery/index.cjs

ENTRYPOINT ["node", ".smithery/index.cjs"]

