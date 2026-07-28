# Claude Code

Configurações compartilháveis do [Claude Code](https://claude.com/claude-code).

> ⚠️ Apenas configs não-sensíveis. O `~/.claude/settings.json` real contém
> permissions, hooks e plugins pessoais e **não** deve ir para este repositório.

## Status line

`statusline-command.sh` desenha a barra de status:

```
<model> <cwd (~ abreviado)> (<git branch>) ⚡<effort> [ctx:<%>]
```

Lê o JSON de estado via stdin (nenhum dado é embutido no script).

### Ativar

O `install.sh` cria o symlink `~/.claude/statusline-command.sh`. Depois,
adicione ao seu `~/.claude/settings.json` o bloco de `settings.example.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline-command.sh"
  }
}
```

Requer `jq` (já incluído no `Brewfile`).
