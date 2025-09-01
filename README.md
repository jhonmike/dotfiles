# Dotfiles

Configurações pessoais para ambiente de desenvolvimento, incluindo Cursor, VSCode, Zsh e Vim.

## Estrutura

```
dotfiles/
├── cursor/             # Configurações do Cursor
│   ├── settings.json
│   └── keybindings.json
├── vscode/            # Configurações do VSCode
│   └── settings.json
├── zsh/               # Configurações do Zsh
│   └── .zshrc
├── vim/               # Configurações do Vim
│   └── .vimrc
├── bkp_linux/         # Backup de configurações Linux (para referência futura)
│   ├── i3/           # Window manager i3
│   └── deepin/       # Deepin terminal
├── .gitconfig         # Configurações do Git
├── Brewfile           # Dependências do Homebrew
├── brew-setup.sh      # Script de instalação do Homebrew
├── install.sh         # Script de instalação dos dotfiles
└── README.md
```

## Instalação

### Setup completo (nova máquina):

```bash
cd ~/dotfiles

# 1. Instalar Homebrew e todas as dependências
./brew-setup.sh

# 2. Configurar dotfiles
./install.sh
```

### Apenas dotfiles (se já tem as dependências):

```bash
cd ~/dotfiles
./install.sh
```

O `brew-setup.sh` irá:

- Instalar Homebrew (se necessário)
- Instalar todas as aplicações e ferramentas de desenvolvimento
- Configurar fontes Nerd Fonts

O `install.sh` irá:

- Fazer backup das configurações existentes
- Criar links simbólicos para as novas configurações
- Instalar o Vim Plug (se necessário)

## Aplicações e Ferramentas Incluídas

### Aplicações GUI:

- **Warp** - Terminal moderno e inteligente
- **Cursor** - Editor com IA integrada
- **Visual Studio Code** - Editor de código
- **Docker Desktop** - Containerização
- **Postman** - Teste de APIs

### Ferramentas de Desenvolvimento:

- **Languages**: Go, Rust, Node.js (nvm), Python (pyenv), Ruby (rbenv)
- **Cloud**: kubectl, helm, terraform, awscli
- **Database**: PostgreSQL, MySQL, SQLite, Redis
- **Build Tools**: Maven, Gradle, CMake, Yarn
- **Version Control**: Git, GitHub CLI, LazyGit

### Utilitários CLI:

- **Modern replacements**: bat (cat), exa (ls), ripgrep (grep), fd (find)
- **System monitoring**: htop, btop
- **Text processing**: jq, yq
- **Terminal**: Starship prompt, Antigen (Zsh plugins), FZF

### Fontes:

- **FiraCode Nerd Font** - Ligatures para código
- **CaskaydiaCove Nerd Font** - Terminal
- **JetBrains Mono Nerd Font** - Alternativa
- **Hack Nerd Font** - Opção adicional

> ✅ Todas as dependências são instaladas automaticamente via `./brew-setup.sh`

## Plugins do Vim

Após a instalação, abra o Vim e execute:

```vim
:PlugInstall
```

### Plugins incluídos:

- **FZF** - Fuzzy finder
- **CtrlP** - File finder
- **Vim Clap** - Modern finder
- **Vim Airline** - Status bar
- **Git Gutter** - Git diff markers
- **Commentary** - Comment toggle
- **ALE** - Linting engine
- **Prettier** - Code formatter
- **Dracula Theme** - Color scheme
- **Clojure**: Conjure, Fireplace, ACID, vim-iced, vim-sexp
- **Language support**: Go, Rust, JavaScript, TypeScript, Vue.js, QML

## Temas e Cores

- **Editor Theme**: Dracula Theme
- **Terminal Font**: CaskaydiaCove Nerd Font (11pt)
- **Editor Font**: FiraCode Nerd Font (12pt) com ligatures

## Atalhos personalizados

### Cursor/VSCode

- `Cmd+I`: Composer Mode Agent
- `Cmd+E`: Composer Mode Background

### Vim

- `<Space>`: Leader key
- `Ctrl+P`: FZF file search
- `Ctrl+E`: Toggle file explorer
- `Ctrl+\`: Open file explorer
- `F5`: Reload .vimrc

## Funcionalidades do Zsh

### Oh-My-Zsh Bundles incluídos:

- **Git**: git shortcuts e informações
- **Kubernetes**: kube-ps1, kubectl, helm, kops
- **Cloud**: aws, terraform, vault
- **Languages**: golang, rust, cargo, node, pip
- **Docker**: docker commands e completions
- **MacOS**: osx specific commands
- **Utils**: command-not-found, translate-shell

### Aliases úteis:

- `k` = `kubectl` (atalho para Kubernetes)

### Prompt features:

- **Starship**: prompt moderno e rápido
- **Kubernetes context**: mostra cluster atual no prompt
- **Vim mode**: navegação estilo Vim no terminal
- **Syntax highlighting**: destaque de sintaxe em comandos
- **Auto-suggestions**: sugestões baseadas no histórico

## Configurações do Git

### Funcionalidades incluídas:

- **Default branch**: `main` por padrão
- **Editor**: Vim como editor padrão
- **Merge tool**: vimdiff para resolução de conflitos
- **Git LFS**: suporte completo ao Git Large File Storage
- **SSH over Git**: URLs `git://` automaticamente convertidas para SSH
- **Auto-cleanup**: `fetch.prune = true` para limpeza automática
- **Cores**: diff, status e branch com cores automáticas
- **Pull strategy**: merge por padrão (não rebase)

### Configuração de GPG (Opcional):

As configurações de GPG estão comentadas por segurança. Para habilitar:

1. Gere uma chave GPG: `gpg --gen-key`
2. Obtenha o ID: `gpg --list-secret-keys --keyid-format LONG`
3. Descomente e configure no `.gitconfig`:
   ```ini
   [user]
     signingkey = YOUR_GPG_KEY_ID
   [commit]
     gpgsign = true
   ```

## Backups e Compatibilidade

### Backup automático

O script de instalação criará automaticamente um backup das suas configurações existentes em `~/.dotfiles-backup-YYYYMMDD-HHMMSS/`.

### Configurações Linux (bkp_linux/)

Este diretório contém configurações antigas do Linux para referência futura:

- **i3**: Window manager para ambientes Linux
- **Deepin Terminal**: Configurações do terminal Deepin

> 💡 **Nota**: As configurações Linux não são aplicadas automaticamente pelo `install.sh`. Use como referência quando configurar um ambiente Linux no futuro.
