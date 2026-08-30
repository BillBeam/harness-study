---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/timer
---

# vendor/timer

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 4 个文件、17 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/timer/README.md

被 vendor 的定时器插件说明文档，给出挂载示例与 `ctx.timeout`/`ctx.interval`/`ctx.throttle`/`ctx.debounce` 的 API 表。

- 无运行期机制

### vendor/timer/package.json

该 vendor 包的清单，声明入口、导出映射、随包文件与对框架的对等依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[vendor/timer/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/package.json#L14-L15)）
- `exports` 只开放 `.`、`./src/*` 与 `./package.json` 三个入口（[vendor/timer/package.json:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/package.json#L16-L23)）
- `files` 限定发布内容为运行期 bundle、类型声明与 `src`（[vendor/timer/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/package.json#L24-L29)）
- 框架声明为对等依赖、`cosmokit` 为运行期依赖（[vendor/timer/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/package.json#L32-L37)）

### vendor/timer/src/index.ts

定时器服务的实现：把 timeout/interval/throttle/debounce 作为随 fiber 释放的效果挂到上下文上。

- 服务以 `timer` 名注册，并用 `ctx.mixin` 把六个方法直接混入上下文（[vendor/timer/src/index.ts:12-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L12-L16)）
- `setTimeout`/`setInterval` 作为别名转发到 `timeout`/`interval`（[vendor/timer/src/index.ts:18-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L18-L26)）
- `timeout` 的回调形态注册一个效果，定时器触发时先调用 disposer 再执行回调，返回值即 disposer（[vendor/timer/src/index.ts:31-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L31-L42)）
- `timeout` 的 Promise 形态在效果释放时清除定时器并以 `Context has been disposed` 拒绝该 Promise，`finally` 里释放效果（[vendor/timer/src/index.ts:43-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L43-L53)）
- `interval` 的回调形态把 `setInterval` 注册成效果，返回的 disposer 清除定时器（[vendor/timer/src/index.ts:59-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L59-L66)）
- `interval` 的迭代器形态每次 tick 解决等待中的 `next()`，效果释放时把迭代器置为抛错终止并拒绝等待中的请求（[vendor/timer/src/index.ts:68-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L68-L80)）
- 迭代器的 `next`/`return`/`throw` 在已终止后分别返回缓存的完成值或拒因，且 `return`/`throw` 会释放定时器效果（[vendor/timer/src/index.ts:81-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L81-L102)）
- `_schedule` 注册一个只做清理的效果：释放时置 `isDisposed` 并清除待触发定时器；返回的包装函数每次调用先清除上一个定时器，并带 `dispose` 属性（[vendor/timer/src/index.ts:106-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L106-L118)）
- `throttle` 以上次执行时间计算剩余间隔：到期立即执行，否则在未释放时安排尾部执行（[vendor/timer/src/index.ts:121-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L121-L136)）
- `debounce` 在每次调用时重排定时器，已释放则不再安排（[vendor/timer/src/index.ts:139-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L139-L144)）
- 模块默认导出 `TimerService`（[vendor/timer/src/index.ts:147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/timer/src/index.ts#L147)）

### vendor/timer/tsconfig.json

该 vendor 包的 TypeScript 编译配置，指定源码与声明输出目录并引用两个工作区包。

- 无运行期机制
