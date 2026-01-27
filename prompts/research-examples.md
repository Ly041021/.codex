---
description: 'research 技能示例：真实提问模板与产出格式'
argument-hint: '[USECASE="learn|debug|compare|latest"]'
---
# Research Strategy Examples

Real-world examples of how to conduct technical research.

---

## Strategy 1: Learn a New Library

**User asks**: "How do I use Better Auth with Figma OAuth?"

### Step-by-step:

1. **Get official docs** (`get_code_context_exa`):
   ```javascript
   {
     query: "Better Auth Figma OAuth provider integration guide 2025",
     tokensNum: 5000
   }
   ```

2. **Find real usage** (`searchGitHub`):
   ```javascript
   {
     query: "figma: {",
     language: ["TypeScript"],
     repo: "better-auth/"
   }
   ```

3. **Read best practices** (`web_search_exa`):
   ```javascript
   {
     query: "Better Auth OAuth provider implementation 2025",
     numResults: 5
   }
   ```

### Expected output:
- Official API documentation
- 3-5 real code examples
- Best practice articles
- Saved to `docs/research/2025-01-09_better-auth-figma-oauth.md`

---

## Strategy 2: Debug an Issue

**User asks**: "Why is my Next.js server action returning undefined?"

### Step-by-step:

1. **Search error message** (`web_search_exa`):
   ```javascript
   {
     query: "Next.js server action returns undefined",
     type: "deep",
     numResults: 8
   }
   ```

2. **Find how others solved it** (`searchGitHub`):
   ```javascript
   {
     query: "(?s)'use server'.*async.*return",
     useRegexp: true,
     language: ["TypeScript", "TSX"]
   }
   ```

3. **Get official guidance** (`get_code_context_exa`):
   ```javascript
   {
     query: "Next.js 15 server actions return values troubleshooting",
     tokensNum: 5000
   }
   ```

### Expected output:
- Common causes of the issue
- 5-10 real code examples showing correct patterns
- Official debugging guide
- Saved to `docs/research/2025-01-09_nextjs-server-action-undefined.md`

---

## Strategy 3: Compare Options

**User asks**: "Should I use Drizzle or Prisma?"

### Step-by-step:

1. **Get latest comparison** (`web_search_exa`):
   ```javascript
   {
     query: "Drizzle vs Prisma 2025 comparison",
     numResults: 5
   }
   ```

2. **Check real adoption** (`searchGitHub`):
   ```javascript
   // Search for Drizzle
   {
     query: "import { drizzle }",
     language: ["TypeScript"]
   }

   // Search for Prisma
   {
     query: "import { PrismaClient }",
     language: ["TypeScript"]
   }

   // Compare result counts
   ```

3. **Read official docs** (`get_code_context_exa`):
   ```javascript
   // Drizzle
   {
     query: "Drizzle ORM 2025 features and benefits",
     tokensNum: 5000
   }

   // Prisma
   {
     query: "Prisma ORM 2025 features and benefits",
     tokensNum: 5000
   }
   ```

### Expected output:
- Side-by-side comparison table
- Adoption statistics from GitHub
- Use case recommendations
- Saved to `docs/research/2025-01-09_drizzle-vs-prisma.md`

---

## Strategy 4: Find Hidden Gems

**User asks**: "How do Vercel engineers handle server-side authentication?"

### Step-by-step:

1. **Search specific repos** (`searchGitHub`):
   ```javascript
   {
     repo: "vercel/",
     query: "(?s)getServerSession.*cookies",
     useRegexp: true,
     language: ["TypeScript"]
   }
   ```

2. **Deep dive articles** (`web_search_exa`):
   ```javascript
   {
     type: "deep",
     query: "Vercel authentication patterns server components",
     numResults: 8
   }
   ```

3. **Get comprehensive context** (`get_code_context_exa`):
   ```javascript
   {
     tokensNum: 20000,
     query: "Next.js authentication server components cookies session"
   }
   ```

### Expected output:
- Advanced patterns from production code
- Vercel-specific best practices
- Comprehensive implementation guide
- Saved to `docs/research/2025-01-09_vercel-auth-patterns.md`

---

## Strategy 5: Investigate Breaking Changes

**User asks**: "What changed in React 19?"

### Step-by-step:

1. **Find official announcement** (`web_search_exa`):
   ```javascript
   {
     query: "React 19 release notes official",
     livecrawl: "preferred",
     numResults: 3
   }
   ```

2. **Compare versions** (`get_code_context_exa`):
   ```javascript
   // React 18
   {
     query: "React 18 features documentation",
     tokensNum: 5000
   }

   // React 19
   {
     query: "React 19 features breaking changes 2025",
     tokensNum: 8000
   }
   ```

3. **Find migration examples** (`searchGitHub`):
   ```javascript
   {
     query: "migrate to React 19",
     path: "README.md"
   }
   ```

### Expected output:
- Breaking changes list
- Migration guide
- Real-world migration examples
- Saved to `docs/research/2025-01-09_react-19-changes.md`

---

## Output Template

Every research session should produce this document:

```markdown
# Research: <Topic>

**Date**: <YYYY-MM-DD>
**Researcher**: Claude Code
**Status**: ✅ Complete

---

## ✅ Direct Answer

<One clear sentence answering the question>

---

## 📊 Evidence from Production Code

**Found in N repositories:**

### Example 1: [Repo name]
**Usage pattern**: [Description]

```typescript
<actual code snippet>
```

**Source**: [GitHub link]

### Example 2: [Another repo]
**Usage pattern**: [Different approach]

```typescript
<actual code snippet>
```

**Source**: [GitHub link]

---

## 📚 Official Guidance

<Key points from get_code_context_exa>

- **Point 1**: [Details]
- **Point 2**: [Details]
- **Point 3**: [Details]

---

## 🎯 Recommended Approach

Based on the evidence above:

1. **Do X** - Because N repositories use this pattern, proven in production
2. **Avoid Y** - Found anti-pattern in M repositories, causes [specific issue]
3. **Consider Z** - Used by major projects like [examples]

### Implementation Steps

1. [Step 1]
2. [Step 2]
3. [Step 3]

---

## ⚠️ Watch Out For

### Pitfall 1: [Name]
**Problem**: [Description]
**Solution**: [How to avoid]

### Pitfall 2: [Name]
**Problem**: [Description]
**Solution**: [How to avoid]

---

## 🔗 References

- [Source 1 with link]
- [Source 2 with link]
- [Source 3 with link]

---

## 📝 Research Notes

<Any additional context, edge cases, or observations>

---

**Research completed on**: <YYYY-MM-DD>
```

---

## Quick Decision Tree

```
User asks research question
    ↓
Is it about a specific library/API?
    YES → get_code_context_exa first
    NO  → Is it about how people solve X?
            YES → searchGitHub first
            NO  → web_search_exa first
    ↓
Found clear answer?
    YES → Verify with second tool
    NO  → Use all three tools
    ↓
Synthesize findings
    ↓
Save to docs/research/
```

---

## Common Mistakes

### ❌ Mistake 1: Using only one tool
**Problem**: Incomplete picture
**Solution**: Always cross-reference at least 2 tools

### ❌ Mistake 2: Trusting first result
**Problem**: May be outdated or wrong
**Solution**: Check multiple sources, prefer 2025 content

### ❌ Mistake 3: Not saving research
**Problem**: Repeat work later
**Solution**: Always save to `docs/research/`

### ❌ Mistake 4: Too generic queries
**Problem**: Noise, not signal
**Solution**: Be specific: include version, year, exact use case

### ❌ Mistake 5: Ignoring real code
**Problem**: Theory without practice
**Solution**: Always check GitHub for production usage

---

## Example Research Documents

### Minimal Research (Simple question)
```markdown
# Research: Next.js 15 Image Component

**Date**: 2025-01-09
**Status**: ✅ Complete

## ✅ Direct Answer
Use next/image with priority prop for above-fold images.

## 📊 Evidence
Found in 50+ repos using priority for hero images.

## 🎯 Recommendation
```tsx
import Image from 'next/image'

<Image src="..." priority alt="..." />
```

**References**:
- [Next.js docs](link)
```

### Comprehensive Research (Complex topic)
```markdown
# Research: Next.js 15 Authentication with Server Actions

**Date**: 2025-01-09
**Status**: ✅ Complete

## ✅ Direct Answer
Use Better Auth with server actions for type-safe, modern auth flow.

## 📊 Evidence from Production Code
[10+ detailed examples with code snippets]

## 📚 Official Guidance
[Comprehensive breakdown of official docs]

## 🎯 Recommended Approach
[Step-by-step implementation guide]

## ⚠️ Watch Out For
[5+ common pitfalls with solutions]

## 🔗 References
[10+ authoritative sources]
```

---

## Time Estimates

| Research Type | Tools Used | Time | Document Size |
|---------------|-----------|------|---------------|
| Quick lookup | 1 tool | 2 min | 50-100 lines |
| Standard research | 2 tools | 5 min | 100-200 lines |
| Deep dive | 3 tools | 10 min | 200-400 lines |
| Comprehensive | 3 tools + iterations | 20 min | 400+ lines |
