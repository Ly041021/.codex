# Codex prompts 使用说明

这些命令来自 `vendor/sync-kingkongshot-prompts.sh` 自动生成。

- 生成目录：`prompts/`（不要手改，重新同步会覆盖）
- 使用方式：在 Codex 里输入 `/prompts:<name>`（输入 `/prompts:` 通常会自动补全）
- 更新后需要重启：Codex CLI 重新开会话 / VSCode 插件 Reload

## 命令列表
- `/prompts:taste-check`：用 Linus ‘good taste’ 体系做代码审查（评分+致命问题+重构优先级）
  - 参数：[SCOPE="file|diff|paste"] [TARGET="<path>"]
- `/prompts:research`：系统化技术调研：官方文档 + 真实代码 + 最新信息（需要 MCP：context7/grep）
  - 参数：[TOPIC="<library|issue>"] [OUTPUT="docs/research/YYYY-MM-DD_topic.md"]
- `/prompts:research-reference`：research 技能参考：工具与参数细节
  - 参数：[QUERY="..."]
- `/prompts:research-examples`：research 技能示例：真实提问模板与产出格式
  - 参数：[USECASE="learn|debug|compare|latest"]
- `/prompts:codex-cli`：Codex CLI 编排：预注入上下文 / 复用会话 / 并行执行（给 VSCode 插件用户的手册）
  - 参数：[TASK="..."]
- `/prompts:codex-cli-reference`：Codex CLI 参考：配置文件、MCP、JSON 事件、常见命令
  - 参数：[SECTION="..."]
- `/prompts:library-usage-researcher`：库用法研究员：Context7 拉官方文档 + Grep 找生产代码例子（需要 MCP）
  - 参数：[LIB="<name>"] [FOCUS="patterns|pitfalls|examples"]
- `/prompts:memory-network-builder`：记忆网络构建：把信息沉淀成可链接的知识图谱/条目
  - 参数：[TOPIC="..."] [OUTPUT_DIR="memory/"]
- `/prompts:commit-as-prompt`：把 git commit / diff 转成高质量任务说明（便于继续 vibe coding）
  - 参数：[RANGE="HEAD~1..HEAD"] [FOCUS="why|what|how"]
- `/prompts:kiro-spec-zh`：Kiro 工作流（中文）：需求→设计→实现→验证 的规范化产出模板
  - 参数：[FEATURE="..."] [CONSTRAINTS="..."]
- `/prompts:kiro-spec`：Kiro workflow（EN）：requirements→design→implementation→validation
  - 参数：[FEATURE="..."]
- `/prompts:obsidian-canvas-framework`：用 Obsidian Canvas 画功能框架图（落地文档/架构沟通）
  - 参数：[MODULE="..."] [SCOPE="..."]

## 备注（别踩坑）
- `research` / `library-usage-researcher` 依赖 MCP 搜索类工具；如果你没配 MCP，会卡在“找资料”这一步。
- `kiro-spec*` 是工作流模板，会要求创建 `.claude/specs/...`；如果你不使用 Claude 生态，照着结构改成你自己的目录即可。
