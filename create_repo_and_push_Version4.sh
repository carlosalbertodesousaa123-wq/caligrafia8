#!/usr/bin/env bash
# Requisitos: gh CLI autenticado (gh auth login), git instalado.
# Execute a partir do diretório onde quer criar o projeto local.

set -e

OWNER="carlosalbertodesousaa123-wq"
REPO="caligrafia8"
FULL="${OWNER}/${REPO}"

# Cria pasta do projeto
mkdir -p "${REPO}"
cd "${REPO}"

# Inicializa git
git init

# Cria arquivos mínimos do scaffold
cat > README.md <<'EOF'
# caligrafia8

(README inicial — reemplazar con la versión final)
EOF

cat > .gitignore <<'EOF'
node_modules
.env
.env.local
.DS_Store
dist
.expo
.expo-shared
build
*.log
EOF

# pnpm workspace config (básico)
cat > pnpm-workspace.yaml <<'EOF'
packages:
  - "apps/*"
  - "packages/*"
EOF

# package.json com workspaces mínimo
cat > package.json <<'EOF'
{
  "name": "caligrafia8-monorepo",
  "private": true,
  "devDependencies": {},
  "workspaces": [
    "apps/*",
    "packages/*"
  ],
  "scripts": {
    "dev:web": "pnpm --filter web dev",
    "dev:mobile": "pnpm --filter mobile start"
  }
}
EOF

# Criar diretórios apps e packages mínimos
mkdir -p apps/web apps/mobile packages/ui packages/common functions assets docs

# Commit inicial
git add .
git commit -m "chore: initial scaffold (README, workspace, dirs)"

# Criar repositório no GitHub (privado) e push — requer gh autenticado
gh repo create "${FULL}" --private --source=. --remote=origin --push

echo "Repo criado e push feito: https://github.com/${FULL}"