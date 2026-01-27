#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/vendor/prompts"
DST="$ROOT/prompts"
USAGE_MD="$ROOT/usage.md"

mkdir -p "$DST"

yaml_quote() {
  local s="${1-}"
  s="${s//\'/\'\'}"
  printf "'%s'" "$s"
}

append_without_front_matter() {
  local srcfile="$1"
  if [[ ! -f "$srcfile" ]]; then
    return 1
  fi

  if [[ "$(head -n 1 "$srcfile")" == "---" ]]; then
    awk '
      NR==1 && $0=="---" {in_fm=1; next}
      in_fm && $0=="---" {in_fm=0; next}
      !in_fm {print}
    ' "$srcfile"
    return 0
  fi

  cat "$srcfile"
}

declare -a USAGE_ENTRIES=()

emit() {
  local out="$1"
  local desc="$2"
  local hint="$3"
  local srcfile="$4"

  if [[ ! -f "$srcfile" ]]; then
    echo "WARN: missing $srcfile"
    return 0
  fi

  local desc_q hint_q
  desc_q="$(yaml_quote "$desc")"
  hint_q="$(yaml_quote "$hint")"

  cat > "$DST/$out" <<EOF
---
description: $desc_q
argument-hint: $hint_q
---
EOF

  # 追加仓库原文（“从仓库提取”），但剥掉源文件自带的 front matter，避免双 front matter。
  append_without_front_matter "$srcfile" >> "$DST/$out"

  # 修正被同步后会失效的相对链接（源仓库里叫 REFERENCE/EXAMPLES，这里是 research-reference/exmaples）。
  if [[ "$out" == "research.md" ]]; then
    sed -i \
      -e 's|./REFERENCE.md|./research-reference.md|g' \
      -e 's|./EXAMPLES.md|./research-examples.md|g' \
      "$DST/$out"
  fi

  USAGE_ENTRIES+=("${out%.md}|$desc|$hint")
  echo "OK: $DST/$out"
}

write_usage_md() {
  cat >"$USAGE_MD" <<'EOF'
# Codex prompts 使用说明

这些命令来自 `vendor/sync-kingkongshot-prompts.sh` 自动生成。

- 生成目录：`prompts/`（不要手改，重新同步会覆盖）
- 使用方式：在 Codex 里输入 `/prompts:<name>`（输入 `/prompts:` 通常会自动补全）
- 更新后需要重启：Codex CLI 重新开会话 / VSCode 插件 Reload

## 命令列表
EOF

  for entry in "${USAGE_ENTRIES[@]}"; do
    IFS='|' read -r name desc hint <<<"$entry"
    {
      echo "- \`/prompts:$name\`：$desc"
      echo "  - 参数：$hint"
    } >>"$USAGE_MD"
  done

  cat >>"$USAGE_MD" <<'EOF'

## 备注（别踩坑）
- `research` / `library-usage-researcher` 依赖 MCP 搜索类工具；如果你没配 MCP，会卡在“找资料”这一步。
- `kiro-spec*` 是工作流模板，会要求创建 `.claude/specs/...`；如果你不使用 Claude 生态，照着结构改成你自己的目录即可。
EOF

  echo "OK: $USAGE_MD"
}

# 1) skills: taste-check（仓库为单文件 SKILL.md）:contentReference[oaicite:25]{index=25}
emit "taste-check.md" \
  "用 Linus ‘good taste’ 体系做代码审查（评分+致命问题+重构优先级）" \
  "[SCOPE=\"file|diff|paste\"] [TARGET=\"<path>\"]" \
  "$SRC/skills/taste-check/SKILL.md"

# 2) skills: research（SKILL/REFERENCE/EXAMPLES 三件套）:contentReference[oaicite:26]{index=26}
emit "research.md" \
  "系统化技术调研：官方文档 + 真实代码 + 最新信息（需要 MCP：context7/grep）" \
  "[TOPIC=\"<library|issue>\"] [OUTPUT=\"docs/research/YYYY-MM-DD_topic.md\"]" \
  "$SRC/skills/research/SKILL.md"

emit "research-reference.md" \
  "research 技能参考：工具与参数细节" \
  "[QUERY=\"...\"]" \
  "$SRC/skills/research/REFERENCE.md"

emit "research-examples.md" \
  "research 技能示例：真实提问模板与产出格式" \
  "[USECASE=\"learn|debug|compare|latest\"]" \
  "$SRC/skills/research/EXAMPLES.md"

# 2.5) skills: codex-cli（SKILL/REFERENCE）
emit "codex-cli.md" \
  "Codex CLI 编排：预注入上下文 / 复用会话 / 并行执行（给 VSCode 插件用户的手册）" \
  "[TASK=\"...\"]" \
  "$SRC/skills/codex-cli/SKILL.md"

emit "codex-cli-reference.md" \
  "Codex CLI 参考：配置文件、MCP、JSON 事件、常见命令" \
  "[SECTION=\"...\"]" \
  "$SRC/skills/codex-cli/REFERENCE.md"

# 3) agents（Claude 体系的专用 agent，转成 Codex 可显式调用的 prompts）:contentReference[oaicite:27]{index=27}
emit "library-usage-researcher.md" \
  "库用法研究员：Context7 拉官方文档 + Grep 找生产代码例子（需要 MCP）" \
  "[LIB=\"<name>\"] [FOCUS=\"patterns|pitfalls|examples\"]" \
  "$SRC/prompts/claude/agents/library-usage-researcher.md"

emit "memory-network-builder.md" \
  "记忆网络构建：把信息沉淀成可链接的知识图谱/条目" \
  "[TOPIC=\"...\"] [OUTPUT_DIR=\"memory/\"]" \
  "$SRC/prompts/claude/agents/memory-network-builder.md"

# 4) commands：commit-as-prompt :contentReference[oaicite:28]{index=28}
emit "commit-as-prompt.md" \
  "把 git commit / diff 转成高质量任务说明（便于继续 vibe coding）" \
  "[RANGE=\"HEAD~1..HEAD\"] [FOCUS=\"why|what|how\"]" \
  "$SRC/prompts/claude/commands/commit-as-prompt.md"

# 5) kiro workflow spec（中英版）:contentReference[oaicite:29]{index=29}
emit "kiro-spec-zh.md" \
  "Kiro 工作流（中文）：需求→设计→实现→验证 的规范化产出模板" \
  "[FEATURE=\"...\"] [CONSTRAINTS=\"...\"]" \
  "$SRC/prompts/kiro/spec_zh.md"

emit "kiro-spec.md" \
  "Kiro workflow（EN）：requirements→design→implementation→validation" \
  "[FEATURE=\"...\"]" \
  "$SRC/prompts/kiro/spec.md"

# 6) visualization：Obsidian Canvas :contentReference[oaicite:30]{index=30}
emit "obsidian-canvas-framework.md" \
  "用 Obsidian Canvas 画功能框架图（落地文档/架构沟通）" \
  "[MODULE=\"...\"] [SCOPE=\"...\"]" \
  "$SRC/prompts/visualization/obsidian-canvas/使用 Obsidian Canvas 绘制功能框架图.md"

write_usage_md

echo
echo "DONE. 现在重启 Codex（CLI 重开会话 / VSCode 里 reload 插件）即可看到 /prompts:*"
