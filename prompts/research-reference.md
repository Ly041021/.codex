---
description: 'research 技能参考：工具与参数细节'
argument-hint: '[QUERY="..."]'
---
# Research Tools Reference

Detailed documentation for all research tools.

---

## searchGitHub

Search GitHub repositories for actual code patterns.

### Basic Usage

**CRITICAL**: Search for **literal code**, not keywords.

✅ **Good queries**:
```javascript
// Finding React useState patterns
query: "useState("
language: ["TypeScript", "TSX"]

// Finding error handling in async functions
query: "(?s)try {.*await"
useRegexp: true
language: ["TypeScript"]

// Finding specific API usage
query: "betterAuth({"
language: ["TypeScript"]
```

❌ **Bad queries**:
```javascript
// These are KEYWORDS, not code patterns
query: "react hooks tutorial"  // Won't find code!
query: "best practices"        // Won't find code!
query: "how to use useState"   // Won't find code!
```

### Advanced Usage

#### 1. Regex for flexible patterns
```javascript
{
  query: "(?s)useState\\(.*loading",  // useState with loading variable
  useRegexp: true,
  language: ["TSX"]
}
```

**Note**: Prefix with `(?s)` to match across multiple lines.

#### 2. Filter by repository
```javascript
{
  query: "getServerSession",
  repo: "vercel/",  // All Vercel repos
  language: ["TypeScript"]
}
```

#### 3. Filter by file path
```javascript
{
  query: "export default {",
  path: "next.config.js",  // Only in Next.js config files
}
```

#### 4. Case sensitivity
```javascript
{
  query: "CORS(",
  matchCase: true,  // Exact case match
  language: ["Python"]
}
```

### Hidden Tricks

**Trick 1: Find specific library usage in popular projects**
```javascript
{
  query: "figma: {",
  repo: "better-auth/",
  language: ["TypeScript"]
}
```

**Trick 2: Search for error handling patterns**
```javascript
{
  query: "(?s)try {.*catch.*error",
  useRegexp: true,
  language: ["TypeScript"]
}
```

**Trick 3: Find configuration patterns**
```javascript
{
  query: "export default {",
  path: "*.config.ts",
}
```

**Trick 4: Find how others handle edge cases**
```javascript
{
  query: "if (!data)",
  language: ["TypeScript"],
  repo: "vercel/"  // Learn from production code
}
```

### Watch Out For

⚠️ **Pitfall 1: Using keywords instead of code**
- Don't search for "react hooks best practices"
- Search for `"useState("` instead

⚠️ **Pitfall 2: Forgetting regex anchors**
- Use `(?s)` for multiline matching
- Escape special chars: `\\{` not `{`

⚠️ **Pitfall 3: Too broad search**
- `"export"` will return millions of results
- Be specific: `"export const auth ="`

⚠️ **Pitfall 4: Ignoring language filter**
- Always specify language to reduce noise
- Use `["TypeScript", "TSX"]` for React projects

---

## get_code_context_exa

Get official documentation and high-quality examples for libraries/APIs.

### Basic Usage

✅ **Good queries**:
```javascript
{
  query: "Next.js 15 server actions best practices",
  tokensNum: 5000
}

{
  query: "Better Auth Figma OAuth integration guide",
  tokensNum: 3000
}

{
  query: "Drizzle ORM PostgreSQL schema migration",
  tokensNum: 8000
}
```

### Advanced Usage

#### 1. Adjust token count based on depth
```javascript
// Quick reference - 1000-3000 tokens
{ query: "React useEffect cleanup", tokensNum: 2000 }

// Comprehensive guide - 5000-10000 tokens
{ query: "Next.js 15 full authentication flow", tokensNum: 8000 }

// Deep dive - 15000-50000 tokens
{ query: "Stripe webhook handling complete guide", tokensNum: 20000 }
```

#### 2. Include version/year for latest docs
```javascript
{
  query: "Next.js 15 2025 app router",  // Specify year!
  tokensNum: 5000
}
```

#### 3. Focus on specific aspects
```javascript
// Not: "React hooks"
// Better: "React hooks performance optimization patterns"

{
  query: "React hooks performance optimization patterns",
  tokensNum: 5000
}
```

### Hidden Tricks

**Trick 1: Compare official docs across versions**
```javascript
// Search 1
{ query: "Next.js 14 server components", tokensNum: 3000 }
// Search 2
{ query: "Next.js 15 server components", tokensNum: 3000 }
// Compare the differences
```

**Trick 2: Get migration guides**
```javascript
{
  query: "migrate from Next.js 14 to 15 breaking changes",
  tokensNum: 8000
}
```

**Trick 3: Find official examples**
```javascript
{
  query: "Vercel Next.js 15 official examples repository",
  tokensNum: 5000
}
```

### Watch Out For

⚠️ **Pitfall 1: Too generic queries**
- "React" → Too broad
- "React Server Components rendering patterns 2025" → Specific

⚠️ **Pitfall 2: Wrong token count**
- Too low (< 2000): May miss critical details
- Too high (> 20000): Wastes time and tokens
- Default 5000 is usually good

⚠️ **Pitfall 3: Outdated docs**
- ALWAYS include year: "2025" or "latest"
- Check account for "Today's date" in context

---

## web_search_exa

Real-time web search for articles, blog posts, discussions.

### Basic Usage

✅ **Good use cases**:
```javascript
// Find recent articles
{
  query: "Next.js 15 performance improvements 2025",
  numResults: 8
}

// Find comparisons
{
  query: "Drizzle vs Prisma 2025 comparison",
  numResults: 5
}

// Find official announcements
{
  query: "Better Auth 2.0 release notes",
  numResults: 3
}
```

### Advanced Usage

#### 1. Adjust result count
```javascript
// Quick scan - 3-5 results
{ query: "React 19 new features", numResults: 3 }

// Comprehensive - 8-10 results
{ query: "Next.js deployment best practices", numResults: 10 }
```

#### 2. Search type
```javascript
// Quick search
{ query: "...", type: "fast" }

// Deep research
{ query: "...", type: "deep" }

// Balanced (default)
{ query: "...", type: "auto" }
```

#### 3. Livecrawl for latest content
```javascript
{
  query: "Next.js 15 RC release notes",
  livecrawl: "preferred",  // Get latest content
  numResults: 3
}
```

### Hidden Tricks

**Trick 1: Find GitHub discussions**
```javascript
{
  query: "site:github.com better-auth figma OAuth issue",
  numResults: 5
}
```

**Trick 2: Official docs only**
```javascript
{
  query: "site:nextjs.org server actions",
  numResults: 3
}
```

**Trick 3: Find real-world war stories**
```javascript
{
  query: "debugging Next.js server actions production",
  type: "deep",
  numResults: 8
}
```

### Watch Out For

⚠️ **Pitfall 1: Generic queries**
- "Next.js tutorial" → Low quality
- "Next.js 15 server actions error handling patterns" → High quality

⚠️ **Pitfall 2: Too many results**
- > 10 results is usually noise
- 3-5 results is often enough

⚠️ **Pitfall 3: Not using site: filter**
- Use `site:` to focus on authoritative sources

---

## Token/Result Guidelines

### searchGitHub
- No limit on results, but first 10-20 are usually enough
- Use specific queries to reduce noise

### get_code_context_exa
| Use Case | Tokens |
|----------|--------|
| Quick API reference | 1000-3000 |
| Comprehensive guide | 5000-10000 |
| Deep documentation | 15000-30000 |
| Exhaustive research | 30000-50000 |

### web_search_exa
| Use Case | Results |
|----------|---------|
| Quick fact check | 1-3 |
| Standard research | 5-8 |
| Comprehensive | 8-10 |
| Avoid > 10 | Too noisy |

---

## Common Patterns

### Pattern 1: "How do I use X?"
1. `get_code_context_exa`: Get official docs (5000 tokens)
2. `searchGitHub`: Find real usage (3-5 examples)
3. `web_search_exa`: Find best practices (5 results)

### Pattern 2: "Why is X not working?"
1. `web_search_exa`: Search exact error (deep, 5 results)
2. `searchGitHub`: Find how others fixed it (regex search)
3. `get_code_context_exa`: Check official troubleshooting (3000 tokens)

### Pattern 3: "X vs Y?"
1. `web_search_exa`: Find comparisons (8 results)
2. `searchGitHub`: Check real adoption (compare result counts)
3. `get_code_context_exa`: Read both official docs (5000 tokens each)

### Pattern 4: "Latest version of X?"
1. `get_code_context_exa`: "X 2025 latest docs" (5000 tokens)
2. `web_search_exa`: "X release notes" (livecrawl: preferred, 3 results)
3. `searchGitHub`: Find recent usage patterns

---

## Quick Troubleshooting

**No results from searchGitHub?**
- Check: Are you using code, not keywords?
- Try: Simplify your query
- Example: `"useState("` not `"react useState hook"`

**Outdated docs from get_code_context_exa?**
- Check: Did you include year in query?
- Try: Add "2025" or "latest" to query

**Too many irrelevant results from web_search_exa?**
- Check: Is query too generic?
- Try: Use `site:` filter for authoritative sources
- Reduce: numResults to 3-5
