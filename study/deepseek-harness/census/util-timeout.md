---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/timeout
---

# packages/util/timeout

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、24 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/timeout/README.md

该包的英文 README，说明超时钳制、截止信号融合、超时与取消的区分以及空闲看门狗的用法，供阅读者与文档站使用。

- 无运行期机制

### packages/util/timeout/package.json

该包的 npm 清单，决定这个工具库以什么入口、什么子路径被其他包导入。

- `type: module` 与 `main`/`types` 把包按 ESM 从 `lib/index.js` 加载（[packages/util/timeout/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/package.json#L13-L15)）
- `exports` 把根入口映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并额外开放 `./src/*` 与 `./package.json` 两个子路径（[packages/util/timeout/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/util/timeout/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/package.json#L28-L32)）

### packages/util/timeout/src/index.ts

该包唯一的实现文件，提供超时钳制、截止信号、空闲看门狗与超时原因识别，被 bash、web、subprocess 与工具超时策略等消费方直接导入。

- `TimeoutReason` 是带 `code` 与 `timeoutMs` 的 Error 子类，消息固定为 `<code> after <ms>ms`，作为 abort 的 reason 被携带（[packages/util/timeout/src/index.ts:12-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L12-L22)）
- 常量把可用定时器延迟上限固定为 2147483647 毫秒（[packages/util/timeout/src/index.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L25)）
- `assertTimerDelay` 对非有限、非正或超过上限的延迟抛出带字段名的错误（[packages/util/timeout/src/index.ts:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L27-L31)）
- `clampTimeout` 对存在但非正或非有限的调用方提示直接抛错（[packages/util/timeout/src/index.ts:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L51-L53)）
- `clampTimeout` 在提示缺省时填入后端默认值，再取与后端上限的较小值（[packages/util/timeout/src/index.ts:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L54)）
- `deadline` 在 `timeoutMs <= 0` 时不装定时器，只转发上游信号，没有上游时给一个永不 abort 的信号，disposer 为空（[packages/util/timeout/src/index.ts:96-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L96-L99)）
- 正数超时先经 `assertTimerDelay` 校验（[packages/util/timeout/src/index.ts:102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L102)）
- 用 `setTimeout` 到期时以 `TimeoutReason` abort 一个独立控制器（[packages/util/timeout/src/index.ts:104-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L104-L105)）
- 有上游时用 `AbortSignal.any` 把上游与定时器融合成一个信号，先中止者的 reason 胜出（[packages/util/timeout/src/index.ts:110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L110)）
- `[Symbol.dispose]` 清除定时器，供 `using` 在作用域退出时调用（[packages/util/timeout/src/index.ts:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L111)）
- `idleWatchdog` 先校验空闲间隔，再构造一个在整次调用中稳定的融合信号（[packages/util/timeout/src/index.ts:131-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L131-L135)）
- `arm` 清掉旧定时器并重新装一个到期即以 `TimeoutReason` abort 的定时器（[packages/util/timeout/src/index.ts:140-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L140-L145)）
- `next` 在已释放或已有未决读取时抛错，否则置未决标记、装上定时器、等待迭代器一次 `next`，并在 finally 清定时器与未决标记（[packages/util/timeout/src/index.ts:149-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L149-L161)）
- `pulse` 只在未释放且有未决读取时重装定时器，否则不做任何事（[packages/util/timeout/src/index.ts:162-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L162-L165)）
- `[Symbol.dispose]` 幂等地置释放标记并清掉已装的定时器（[packages/util/timeout/src/index.ts:166-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L166-L171)）
- `timeoutOf` 取出信号或错误上的 `reason`，只在它是 `TimeoutReason` 且（未指定 code 或 code 完全相同）时返回，否则返回 `undefined`（[packages/util/timeout/src/index.ts:184-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/index.ts#L184-L190)）

### packages/util/timeout/src/invariant.ts

该包的 invariant 伴生插件，被 invariants 服务加载以登记包所有权。

- 导出 `name` 与 `inject`，把伴生插件命名为 `timeout-invariant` 并声明依赖 `invariants` 服务（[packages/util/timeout/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/invariant.ts#L13-L15)）
- 安装函数为空体，不注册任何运行期检查（[packages/util/timeout/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该安装函数并返回其 disposer（[packages/util/timeout/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/timeout/src/invariant.ts#L28-L29)）

### packages/util/timeout/tsconfig.json

该包的 TypeScript 编译配置，规定源目录、声明输出目录与工程引用。

- 无运行期机制
