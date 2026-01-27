---
description: 'Codex CLI 参考：配置文件、MCP、JSON 事件、常见命令'
argument-hint: '[SECTION="..."]'
---
# Codex CLI Reference

## Prompt 设计详解

### 好 Prompt 的结构

```
[任务动词] + [目标范围] + [具体要求] + [输出格式] + [约束条件]
```

**示例分解**：
```
Review src/auth/           # 任务动词 + 目标范围
for SQL injection risks.   # 具体要求
List each vulnerability    # 输出格式
with file:line, code snippet, and fix suggestion.
Do not modify any files.   # 约束条件
```

### 动词选择指南

| 动词 | 含义 | 适用场景 |
|------|------|----------|
| `analyze` | 分析并报告 | 只读理解 |
| `review` | 审查并评价 | 代码审查 |
| `find` | 查找并列出 | 搜索定位 |
| `explain` | 解释说明 | 文档/理解 |
| `refactor` | 重构代码 | 结构改进 |
| `fix` | 修复问题 | Bug 修复 |
| `implement` | 实现功能 | 新功能开发 |
| `add` | 添加内容 | 增量开发 |
| `migrate` | 迁移转换 | 升级/转换 |
| `optimize` | 优化性能 | 性能调优 |

### 输出格式控制

**Markdown 报告**：
```bash
codex exec "... Output as markdown with ## headings for each category."
```

**JSON 结构化**：
```bash
codex exec "... Output as JSON array: [{file, line, issue, severity}]"
```

**纯文本列表**：
```bash
codex exec "... Output as numbered list, one issue per line."
```

**表格格式**：
```bash
codex exec "... Output as markdown table with columns: File | Line | Issue | Fix"
```

### 范围限定技巧

**目录限定**：
```bash
codex exec --cd src/auth "..."  # 工作目录限定
codex exec "analyze only files in src/utils/"  # prompt 限定
```

**文件类型限定**：
```bash
codex exec "review only *.ts files, ignore *.test.ts"
```

**深度限定**：
```bash
codex exec "analyze top-level architecture, do not dive into implementation details"
```

**排除限定**：
```bash
codex exec "refactor all components except shared/legacy/"
```

### 并行 Prompt 设计

**规则 1: 结构一致**

所有并行任务使用相同的 prompt 结构，只替换变量部分：

```bash
# 好：结构一致
codex exec "analyze src/auth for security. Output JSON." &
codex exec "analyze src/api for security. Output JSON." &
codex exec "analyze src/db for security. Output JSON." &

# 差：结构不一致，难以聚合
codex exec "check auth security" &
codex exec "find api vulnerabilities and list them" &
codex exec "security audit for database layer, markdown format" &
```

**规则 2: 输出格式统一**

```bash
# 统一输出格式便于聚合
FORMAT="Output as JSON: {category, items: [{file, line, description}]}"

codex exec "review code quality. $FORMAT" &
codex exec "review security. $FORMAT" &
codex exec "review performance. $FORMAT" &
```

**规则 3: 任务边界清晰**

```bash
# 好：边界清晰，无重叠
codex exec "review authentication logic in src/auth/" &
codex exec "review authorization logic in src/authz/" &
codex exec "review session management in src/session/" &

# 差：边界模糊，可能重复分析
codex exec "review security" &
codex exec "find vulnerabilities" &
codex exec "check for security issues" &
```

### 常见 Prompt 反模式

| 反模式 | 问题 | 修复 |
|--------|------|------|
| 太宽泛 | "improve code" | 具体说明改进什么方面 |
| 无输出格式 | "find bugs" | 添加输出格式要求 |
| 隐含期望 | "review code" | 明确检查哪些方面 |
| 否定指令 | "don't be verbose" | 说"be concise" |
| 多目标混合 | "fix bugs and add tests and refactor" | 拆分为多个任务 |

### 高级 Prompt 技巧

**链式推理**：
```bash
codex exec "First, identify all API endpoints. Then, for each endpoint, check if it has proper authentication. Finally, list unprotected endpoints."
```

**自验证**：
```bash
codex exec --full-auto "implement the function, then write a test, then run the test to verify"
```

**上下文注入**：
```bash
codex exec "Given this error log: $(cat error.log | tail -20), find the root cause in src/"
```

**迭代细化**：
```bash
# 第一轮：广度分析
codex exec "list all potential issues in src/"

# 第二轮：深度分析（基于第一轮结果）
codex exec "deep dive into the SQL injection risk in src/db/query.ts:42"
```

---

## 命令行参数完整列表

### codex exec

| 参数 | 简写 | 说明 |
|------|------|------|
| `--model` | `-m` | 指定模型 (o3, o4-mini, gpt-5.1, gpt-5.1-codex-max) |
| `--full-auto` | | 允许文件编辑 (workspace-write sandbox) |
| `--sandbox` | | 沙盒模式: `read-only`, `workspace-write`, `danger-full-access` |
| `--json` | | JSON Lines 输出模式 |
| `--output-last-message` | `-o` | 输出最终消息到文件或 stdout |
| `--output-schema` | | 使用 JSON Schema 获取结构化输出 |
| `--cd` | `-C` | 指定工作目录 |
| `--add-dir` | | 添加额外可写目录 |
| `--skip-git-repo-check` | | 跳过 Git 仓库检查 |
| `--profile` | | 使用配置 profile |
| `--ask-for-approval` | `-a` | 审批策略 |
| `--image` | `-i` | 附加图片文件 (逗号分隔) |

---

## 沙盒模式详解

### read-only (默认)
- 可以读取任何文件
- 不能写入文件
- 不能访问网络

```bash
codex exec "analyze this code"
```

### workspace-write
- 可以读写工作目录内的文件
- 可以读写 $TMPDIR 和 /tmp
- .git/ 目录只读
- 不能访问网络

```bash
codex exec --full-auto "fix the bug"
# 等同于
codex exec --sandbox workspace-write "fix the bug"
```

### danger-full-access
- 完全磁盘访问
- 完全网络访问
- **谨慎使用**

```bash
codex exec --sandbox danger-full-access "install deps and run tests"
```

---

## 审批策略

| 策略 | 说明 |
|------|------|
| `untrusted` | 不信任的命令需要审批 |
| `on-failure` | 失败时请求审批重试 |
| `on-request` | 模型决定何时请求审批 |
| `never` | 从不请求审批 (exec 默认) |

---

## JSON 事件类型

### 线程事件
- `thread.started` - 线程启动
- `turn.started` - 回合开始
- `turn.completed` - 回合完成 (包含 token 使用量)
- `turn.failed` - 回合失败

### 项目事件
- `item.started` - 项目开始
- `item.updated` - 项目更新
- `item.completed` - 项目完成

### 项目类型
- `agent_message` - 助手消息
- `reasoning` - 推理摘要
- `command_execution` - 命令执行
- `file_change` - 文件变更
- `mcp_tool_call` - MCP 工具调用
- `web_search` - 网络搜索
- `todo_list` - 任务列表更新

### JSON 输出示例

```jsonl
{"type":"thread.started","thread_id":"..."}
{"type":"turn.started"}
{"type":"item.completed","item":{"id":"item_0","type":"reasoning","text":"**Analyzing code**"}}
{"type":"item.completed","item":{"id":"item_1","type":"command_execution","command":"bash -lc ls","aggregated_output":"...","exit_code":0,"status":"completed"}}
{"type":"item.completed","item":{"id":"item_2","type":"agent_message","text":"Analysis complete."}}
{"type":"turn.completed","usage":{"input_tokens":24763,"output_tokens":122}}
```

---

## 结构化输出

### Schema 示例

```json
{
  "type": "object",
  "properties": {
    "project_name": { "type": "string" },
    "issues": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "file": { "type": "string" },
          "line": { "type": "number" },
          "description": { "type": "string" }
        },
        "required": ["file", "line", "description"],
        "additionalProperties": false
      }
    }
  },
  "required": ["project_name", "issues"],
  "additionalProperties": false
}
```

### 使用方法

```bash
codex exec --output-schema issues.schema.json -o issues.json "find all TODO comments"
```

---

## 认证方式

### 方式 1: ChatGPT 登录 (推荐)
```bash
codex  # 交互式登录
```

### 方式 2: API Key
```bash
export CODEX_API_KEY=sk-...
codex exec "your prompt"
```

---

## 配置文件

位置: `~/.codex/config.toml`

### 常用配置

```toml
# 默认模型
model = "gpt-5.1"

# 审批策略
approval_policy = "never"

# 沙盒模式
sandbox_mode = "workspace-write"

# MCP 服务器
[mcp_servers.github]
command = "npx"
args = ["-y", "@modelcontextprotocol/server-github"]
env = { GITHUB_PERSONAL_ACCESS_TOKEN = "..." }
```

### Profile 配置

```toml
[profiles.fast]
model = "o4-mini"
model_reasoning_effort = "low"

[profiles.powerful]
model = "o3"
model_reasoning_effort = "high"
```

使用: `codex exec --profile powerful "complex task"`

---

## 常见问题

### Q: 如何跳过 Git 仓库检查?
```bash
codex exec --skip-git-repo-check "your prompt"
```

### Q: 如何在后台运行?
```bash
codex exec --json "long task" > output.jsonl 2>&1 &
```

### Q: 如何处理超时?
JSON 模式下可以实时监控进度:
```bash
codex exec --json "task" | while read -r line; do
  type=$(echo "$line" | jq -r '.type // empty')
  [ -n "$type" ] && echo "Event: $type"
done
```

### Q: 如何查看调试日志?
```bash
RUST_LOG=debug codex exec "task"
# 或查看日志文件
tail -F ~/.codex/log/codex-tui.log
```

---

## 模型选择指南

| 模型 | 特点 | 推荐场景 |
|------|------|----------|
| `gpt-5.1-codex-max` | 默认，平衡 | 通用任务 |
| `o3` | 强推理 | 复杂算法、架构设计 |
| `o4-mini` | 快速 | 简单任务、快速迭代 |
| `gpt-5.1` | 通用 | 代码生成、重构 |
| `gpt-5.1-codex` | 代码优化 | 编程任务 |

---

## 并行执行详解

### 并行度决策表

| 任务类型 | 并行度 | 原因 |
|----------|--------|------|
| 多目录相同分析 | 高 (目录数) | 文件完全隔离 |
| 多维度分析 | 高 (维度数) | 只读无冲突 |
| 多模块测试 | 中-高 | 通常隔离良好 |
| 多文件修复 | 低 | 可能有共享依赖 |
| 单文件多修复 | 1 (串行) | 写入冲突 |

### 后台执行模式

```bash
# 模式 1: 简单后台 (输出到文件)
codex exec "task" > output.txt 2>&1 &
PID=$!

# 模式 2: 带进程组管理
(codex exec "task" > output.txt 2>&1) &

# 模式 3: 使用 nohup (防止终端关闭中断)
nohup codex exec "task" > output.txt 2>&1 &
```

### 等待与超时

```bash
# 等待所有后台任务
wait

# 等待特定 PID
wait $PID1 $PID2

# 带超时等待 (使用 timeout)
timeout 300 bash -c 'codex exec "task"'
```

### 并行任务状态监控

```bash
# 启动并记录 PID
codex exec "task1" > t1.txt 2>&1 & PID1=$!
codex exec "task2" > t2.txt 2>&1 & PID2=$!
codex exec "task3" > t3.txt 2>&1 & PID3=$!

# 检查是否完成
for pid in $PID1 $PID2 $PID3; do
  if kill -0 $pid 2>/dev/null; then
    echo "PID $pid still running"
  else
    echo "PID $pid completed"
  fi
done

# 等待全部
wait
```

### JSON 模式并行输出聚合

```bash
# 并行执行，输出 JSON
codex exec --json "analyze auth" > auth.jsonl 2>&1 &
codex exec --json "analyze api" > api.jsonl 2>&1 &
wait

# 提取所有最终消息
for f in *.jsonl; do
  echo "=== $f ==="
  grep '"type":"agent_message"' "$f" | jq -r '.msg.text // .item.text'
done
```

### 错误处理

```bash
# 捕获退出码
codex exec "task1" > t1.txt 2>&1 &
PID1=$!
codex exec "task2" > t2.txt 2>&1 &
PID2=$!

wait $PID1
STATUS1=$?
wait $PID2
STATUS2=$?

echo "Task1 exit: $STATUS1, Task2 exit: $STATUS2"
```

---

## 编排最佳实践

### 1. 先分析再执行

```bash
# Step 1: 只读分析，理解任务范围
codex exec "list all modules and their dependencies"

# Step 2: 根据分析结果决定并行策略
# (Claude Code 分析输出，规划并行组)

# Step 3: 执行
```

### 2. 渐进式权限升级

```bash
# 先只读验证方案
codex exec "explain how you would fix this bug"

# 确认后再写入
codex exec --full-auto "fix the bug as explained"
```

### 3. 结果验证

```bash
# 并行执行
codex exec --full-auto --cd module-a "add tests" &
codex exec --full-auto --cd module-b "add tests" &
wait

# 验证结果
codex exec "verify that all new tests pass"
```

### 4. 冲突预防

写入任务时，确保：
- 不同实例操作不同文件
- 或使用 `--cd` 隔离工作目录
- 或使用串行执行

---

## 与 Claude Code 配合

### 分工策略

| 角色 | 职责 |
|------|------|
| **Claude Code** | 规划、编排、审查、精细编辑 |
| **Codex** | 批量执行、自动化、测试运行 |

### 编排流程

```
1. 用户提出任务
       ↓
2. Claude Code 分析任务
       ↓
3. 分解为子任务，判断隔离性
       ↓
4. 并行启动多个 codex 实例
       ↓
5. 等待完成，收集结果
       ↓
6. Claude Code 聚合结果，报告用户
```

### 典型场景

**场景 A: 代码审查**
```
Claude Code: 识别 4 个审查维度
  → 并行 4 个 codex (安全/性能/质量/风格)
  → 聚合为综合报告
```

**场景 B: 多模块开发**
```
Claude Code: 识别 3 个独立模块
  → 并行 3 个 codex (各自开发)
  → 串行 1 个 codex (集成测试)
```

**场景 C: 渐进修复**
```
Claude Code: 分析依赖关系
  → 串行修复基础模块
  → 并行修复上层模块
```
