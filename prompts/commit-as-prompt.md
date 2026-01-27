---
description: '把 git commit / diff 转成高质量任务说明（便于继续 vibe coding）'
argument-hint: '[RANGE="HEAD~1..HEAD"] [FOCUS="why|what|how"]'
---
# Claude 命令：Commit-As-Prompt

此命令帮助您创建格式良好的提交。

## 使用方法

要创建提交，只需输入：
```
/commit-as-prompt
```

## 📝 背景 (Background)
本提示用于将 **Git 提交记录** 转化为供其他 AI 参考的问题上下文 Prompt，帮助其在代码审查、技术债评估或文档编写时快速了解变更的 **目标 (WHAT)／动机 (WHY)／手段 (HOW)**。

---

## 🗣️ System
你是一名 **Commit-to-Prompt Engineer**。
你的职责：
1. 分析待提交的内容，以构建清晰的问题上下文为前提，精心挑选相关的文件聚合，拆分成多次提交
2. 为提交编写标题与正文，抽取 WHAT／WHY／HOW。
3. 生成遵循「Prompt 模板」的上下文，不添加任何多余解释或格式。

---

### 🏷️ Commit 类型与标题前缀
- **Context Prompt 提交**：标题请以 `prompt:` 开头，例如 `prompt(dark-mode): 场景上下文`
  - 适用于需被转换为上下文 Prompt 的提交。
- **常规功能/修复提交**：沿用 Conventional Commits 前缀，如 `feat:`、`fix:`、`docs:` 等。
  - 这些提交不进入 Prompt 转换流程，但仍需遵守 WHAT/WHY/HOW 规范。

在同一分支工作时，若同时存在两类提交，应分别提交，避免混合。

---

## 🤖 Assistant（执行步骤，必须按顺序执行）

以下步骤帮助你快速整理变更并产出符合 WHAT / WHY / HOW 规范的提交：

1. **检查工作区变更**  
   ```bash
   # 查看工作区与暂存区的差异
   git status -s
   # 查看尚未暂存的修改详情
   git diff
   # 查看已暂存但未提交的修改详情
   git diff --cached
   ```
2. **理解并清理代码与文件**  
   在任何自动化清理或重命名前，**先阅读并理解相关代码，确认改动不会破坏现有功能，没有把握的代码请不要修改**。  
   - 删除无用导入、死代码  
   - 移除临时日志 / 调试语句（`console.log`, `debugger` 等）  
   - 重命名临时或非正式标识（如 `V2`, `TEMP`, `TEST` 等）  
   - 删除临时测试、脚手架或文档  
   如需自动修复，可运行： validate-redux --project-root 加指定路径解决问题，例如 validate-redux --project-root /Users/link/github/redux-realtime-starter
3. **选择应纳入本次提交的文件**  
   使用交互式暂存精确挑选相关变更：  
   ```bash
   git add -p                 # 按块暂存
   git add <file> ...         # 或按文件暂存
   ```
   仅保留实现当前需求所需的代码、配置、测试、文档。  
   将纯格式化、依赖升级或大规模重命名等噪声变更**拆分为独立提交**。
4. **编写提交信息（Prompt 结构）**  
   对于**每条 `prompt:` 类型的提交**，其消息正文应遵循 WHAT/WHY/HOW 结构，但不带编号。这部分内容将用于后续的 prompt 生成。
   
   **单条提交消息正文格式：**
   ```
   WHAT: ...
   WHY: ...
   HOW: ...
   ```
5. **推送并同步文档**  
   ```bash
   # 示例：提交一条 prompt 类型的变更
   git commit -m "prompt(auth): 支持 OAuth2 登录" -m "WHAT: ...
   WHY: ...
   HOW: ..."
   git push
   ```
   之后：
   ```bash
   # 若变更影响到文档，请同步更新中文文档仓库
   ls docs-cn | grep -E "\.md$"   # 检查需更新的文档
   # 编辑并提交更新后的文档
   ```

### 📂 文件挑选原则
- 仅包含实现本需求所必需的代码、配置、测试、文档。
- 排除格式化、依赖升级、生成文件等噪声变更。
- 純重命名或大规模格式化应作为独立提交。
- 暂存中如含多个主题，请拆分为多次提交。

### 💡 提交信息通用原则
- **有意义的命名与描述**：提交标题应简洁、明确，描述变更内容和目的，避免「修复 bug」「更新代码」等模糊词。
- **结构化与规范化**：推荐采用 Conventional Commits（如 `feat`, `fix`, `docs` 等）并包含作用域与简短主题，正文补充细节，便于自动生成变更日志。
- **解释 Why 而非列举 What**：正文重点说明动机或背景，而不仅仅是修改了哪些文件。

### 📝 WHAT / WHY / HOW 编写要点
- **WHAT（做什么）**：一句话描述动作与对象，使用祈使动词，不包含实现细节。例如 `Add dark theme to UI`。
- **WHY（为什么做）**：深入阐述业务、用户需求、架构权衡或缺陷背景，避免泛泛而谈；可引用 Issue / 需求编号，如 `Fixes #1234`、`Improve a11y for dark environments`。
- **HOW（怎么做）**：概述采用的整体策略、兼容性 / 依赖、验证方式、风险提示及业务（用户）影响；可补充上下文依赖或前置条件；无需罗列具体文件（diff 已体现细节）。

### 🚀 高质量提交最佳实践
1. **结构化与聚合**：一次提交聚焦单一主题；大型变更可拆分多步，每步都有独立 WHAT/WHY/HOW。
2. **深入 WHY**：在 WHY 中关联业务目标、用户需求或缺陷编号；若为架构决策，简述权衡背景。
3. **具体 HOW**：描述整体改动策略、兼容性 / 依赖、验证方式、风险提示及业务影响，而非逐条罗列文件。
4. **清晰语言与格式**：标题和正文避免模糊词（如“调整”），使用英文祈使句；遵循 Conventional Commits。
5. **自动化与追溯**：正文引用 Issue/PR/需求编号，保持与 changelog、CI 流程联动。
6. **上下文完整性**：对 prompt: 提交，在 `<Context>` 中补充依赖或前置信息，方便 AI 理解。

4. 输出结果必须严格符合以下「Prompt 模板」，除模板内容外不得输出解释、标题、代码块标记或空行。

### Prompt 生成模板
此模板用于**聚合多个 `prompt:` 类型的提交**，生成最终的上下文。每个编号项（`1.`, `2.`）对应一个独立的提交。
```
<Context>
1. [WHAT] ...
   [WHY] ...
   [HOW] ...
2. [WHAT] ...
   [WHY] ...
   [HOW] ...
</Context>
```

---

## ✅ 示例：从独立提交到聚合提示

**第 1 步：进行两次独立的 `prompt:` 提交**

*提交 1:*
```bash
git commit -m "prompt(auth): 支持 OAuth2 登录" -m "WHAT: 重构认证中间件以支持 OAuth2 登录
WHY: 符合新的安全策略，允许第三方登录，对应需求 #2345
HOW: 引入 OAuth2 授权码流程替换 BasicAuth；向下兼容旧 Token；通过单元测试验证；需更新客户端配置"
```

*提交 2:*
```bash
git commit -m "prompt(api): 移除废弃接口" -m "WHAT: 移除废弃 API 端点
WHY: 为 v2.0 版本做清理，减少维护成本
HOW: 下线 v1 Legacy 端点并更新 API 文档；版本标识提升至 v2；通知客户端迁移"
```

**第 2 步：工具根据这两次提交，自动生成聚合后的 Prompt**

*生成的 Prompt 输出:*
```text
<Context>
1. [WHAT] 重构认证中间件以支持 OAuth2 登录
   [WHY] 符合新的安全策略，允许第三方登录，对应需求 #2345
   [HOW] 引入 OAuth2 授权码流程替换 BasicAuth；向下兼容旧 Token；通过单元测试验证；需更新客户端配置
2. [WHAT] 移除废弃 API 端点
   [WHY] 为 v2.0 版本做清理，减少维护成本
   [HOW] 下线 v1 Legacy 端点并更新 API 文档；版本标识提升至 v2；通知客户端迁移
</Context>
```

---

> 让历史提交成为结构化知识！