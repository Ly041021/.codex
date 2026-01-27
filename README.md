# Codex Default Config (Personal)

这是我个人的 OpenAI Codex（CLI / VSCode 插件）默认配置目录，目标是：开箱即用的 `/prompts:*` 命令 + 可复用的工作流提示词 + 最小可用的 MCP 配置。

本仓库的 prompts 设计与组织方式，参考并借鉴了 [kingkongshot/prompts](https://github.com/kingkongshot/prompts)。感谢原作者的整理与沉淀。

## 目录结构

- `config.toml`：Codex CLI 配置（模型、特性开关、MCP 服务器等）
- `prompts/`：在 Codex 里可直接调用的 prompts（输入 `/prompts:` 会自动补全）
- `usage.md`：自动生成的命令清单与用法速览
- `vendor/sync-kingkongshot-prompts.sh`：从 `vendor/prompts` 生成/刷新 `prompts/` 与 `usage.md`
- `AGENTS.md`：我的“Linus 风格”协作与输出规范（给模型看的）

## 快速开始

1. 把仓库放到 `~/.codex/`（或你自己的 Codex 配置目录）。
2. 生成 prompts（会覆盖 `prompts/` 和 `usage.md`）：
   ```bash
   bash vendor/sync-kingkongshot-prompts.sh
   ```
3. 重启 Codex（CLI 重新开会话 / VSCode 插件 Reload）。
4. 在 Codex 输入：
   - `/prompts:` 看是否出现命令补全
   - 或直接用 `/prompts:taste-check`、`/prompts:research` 等

完整命令列表见 `usage.md`。

## MCP

此仓库默认在 `config.toml` 里配置了最小可用的 MCP：

- `context7`：拉取库/框架的官方文档片段
- `grep`：搜索真实 GitHub 代码用法

检查方式：
```bash
codex mcp list
```

可选：如果你想要更强的网页检索（exa），需要先准备 `EXA_API_KEY`，然后：
```bash
export EXA_API_KEY="你的key"
codex mcp add exa --url https://mcp.exa.ai/mcp --bearer-token-env-var EXA_API_KEY
```

## 更新 prompts（你改了 vendor 之后）

```bash
bash vendor/sync-kingkongshot-prompts.sh
```

`prompts/` 是生成产物，不建议手改；要改就改 `vendor/prompts` 或同步脚本。

## 安全提示（别把密钥推上 GitHub）

本仓库包含运行时/账号相关文件（例如 `auth.json`、`sessions/`），它们不应该被提交。
我已经提供了 `.gitignore`，但你在 `git add` 前仍然要自己确认一遍：

```bash
git status
```

