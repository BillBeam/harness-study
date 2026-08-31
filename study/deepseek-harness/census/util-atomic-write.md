---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/atomic-write
---

# packages/util/atomic-write

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、20 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/atomic-write/README.md

包 README，说明原子替换与跨进程写者锁的用法、失败情形与实现取舍。

- 无运行期机制

### packages/util/atomic-write/package.json

包清单，声明入口、子路径导出与发布内容。

- `type: module` 与 `main`/`types` 把包入口指向 `lib/index.js` 及其声明文件（[packages/util/atomic-write/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/package.json#L13-L15)）
- `exports` 把 `.` 与 `./invariant` 解析到 `lib` 产物，并把 `./src/*` 直通源码目录（[packages/util/atomic-write/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/package.json#L16-L27)）
- `files` 把发布内容限定为两个 `lib` 入口与 `lib/types` 下的 d.ts（[packages/util/atomic-write/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/package.json#L28-L32)）

### packages/util/atomic-write/src/index.ts

包的全部实现：`writeFileAtomic` 做整份内容的原子替换，`withFileLock` 用同名 `.lock` 兄弟文件串行化跨进程写者；被文件型存储（用户设置文档、凭据存储）使用。

- `writeFileAtomic` 先递归创建父目录，`dirMode` 给定时作为新建目录的权限传入（[packages/util/atomic-write/src/index.ts:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L50-L53)）
- 临时文件名由目标路径加 6 个随机字节的十六进制再加 `.tmp` 构成，位于同一目录（[packages/util/atomic-write/src/index.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L56)）
- 内容以 `wx` 独占创建写入临时文件并带上调用方给定的 `mode`，随后 `rename` 覆盖目标（[packages/util/atomic-write/src/index.ts:58-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L58-L59)）
- 写入或改名失败时以 `force` 删除临时文件后把原错误重新抛出，目标保持不变（[packages/util/atomic-write/src/index.ts:60-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L60-L63)）
- `isLockContention` 把 `EEXIST` 直接判为争用，`EPERM` 只有在 `lstat` 确认锁路径存在时才算争用，`lstat` 失败则不算（[packages/util/atomic-write/src/index.ts:67-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L67-L78)）
- 退避节奏固定为初始 20 毫秒、上限 200 毫秒（[packages/util/atomic-write/src/index.ts:85-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L85-L86)）
- 未指定 `waitMs` 时的等待上限为 2000 毫秒（[packages/util/atomic-write/src/index.ts:97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L97)）
- `withFileLock` 以 `<filename>.lock` 为锁路径，并按当前时间加 `waitMs`（缺省用默认值）算出截止时刻（[packages/util/atomic-write/src/index.ts:133-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L133-L134)）
- 获取锁的循环用 `wx` 写入包含 `process.pid` 的锁文件、权限 `0o600`，成功即跳出；非争用错误直接抛出（[packages/util/atomic-write/src/index.ts:136-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L136-L142)）
- 到达截止时刻仍未拿到锁时抛出带锁路径的超时错误，而不删除已有锁（[packages/util/atomic-write/src/index.ts:143-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L143-L145)）
- 每次争用后等待当前延迟，再把延迟翻倍并截到上限（[packages/util/atomic-write/src/index.ts:146-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L146-L147)）
- 操作在 `try` 中执行并返回其结果，`finally` 中以 `force` 删除锁文件，成功与失败都释放（[packages/util/atomic-write/src/index.ts:149-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L149-L153)）

### packages/util/atomic-write/src/invariant.ts

包自有的 invariant 伴生插件，被 `./invariant` 子路径导出。

- 导出 `name` 与 `inject`，声明插件名并要求先有 `invariants` 服务（[packages/util/atomic-write/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/invariant.ts#L12-L15)）
- `install` 为空函数，注册后不安装任何检查（[packages/util/atomic-write/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该 installer，并把注册返回的 disposer 包成 Promise 返回（[packages/util/atomic-write/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/invariant.ts#L28-L29)）

### packages/util/atomic-write/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
