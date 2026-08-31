---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/crypto
---

# packages/util/crypto

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、12 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/crypto/README.md

包 README，说明为什么用 `crypto.getRandomValues` 铸造 UUID，以及该包对外的三个导出。

- 无运行期机制

### packages/util/crypto/package.json

包清单，声明入口、子路径导出与发布内容。

- `type: module` 与 `main`/`types` 把包入口指向 `lib/index.js` 及其声明文件（[packages/util/crypto/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/package.json#L13-L15)）
- `exports` 把 `.` 与 `./invariant` 解析到 `lib` 产物，并把 `./src/*` 直通源码目录（[packages/util/crypto/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/package.json#L16-L27)）
- `files` 把发布内容限定为两个 `lib` 入口与 `lib/types` 下的 d.ts（[packages/util/crypto/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/package.json#L28-L32)）

### packages/util/crypto/src/index.ts

包的全部实现：字节到 base64 的编码与不依赖安全上下文的 v4 UUID 铸造，被各处铸造请求、会话与附件标识符的调用方使用。

- `bytesToBase64` 以 0x8000 字节为一块调用 `String.fromCharCode` 拼接，再整体 `btoa`，避免一次传入过多参数（[packages/util/crypto/src/index.ts:20-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/index.ts#L20-L27)）
- `randomUUID` 从 `globalThis.crypto.getRandomValues` 取 16 个随机字节，而不调用 `crypto.randomUUID`（[packages/util/crypto/src/index.ts:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/index.ts#L33-L34)）
- 第 6 字节的高半字节被置为 4、第 8 字节的高两位被置为 `10`，其余字节原样，逐字节转两位十六进制（[packages/util/crypto/src/index.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/index.ts#L36-L39)）
- 32 位十六进制串按 8-4-4-4-12 切分并用连字符拼成返回值（[packages/util/crypto/src/index.ts:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/index.ts#L40)）

### packages/util/crypto/src/invariant.ts

包自有的 invariant 伴生插件，被 `./invariant` 子路径导出。

- 导出 `name` 与 `inject`，声明插件名并要求先有 `invariants` 服务（[packages/util/crypto/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/invariant.ts#L12-L15)）
- `install` 为空函数，注册后不安装任何检查（[packages/util/crypto/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该 installer，并把注册返回的 disposer 包成 Promise 返回（[packages/util/crypto/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/invariant.ts#L28-L29)）

### packages/util/crypto/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
