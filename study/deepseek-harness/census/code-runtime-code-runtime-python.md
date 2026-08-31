---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/code-runtime/code-runtime-python
---

# packages/code-runtime/code-runtime-python

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、41 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/code-runtime/code-runtime-python/README.md

CPython 后端 fd-3 线协议包的说明文档，描述帧词汇、宿主侧校验与无损 JSON 穿越。

- 无运行期机制

### packages/code-runtime/code-runtime-python/package.json

该包的 npm 清单，声明入口、导出映射与发布文件白名单。

- `main` 与 `types` 指向构建产物 `lib/index.js` 与类型声明（[packages/code-runtime/code-runtime-python/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/package.json#L14-L15)）
- `exports` 暴露包根、`./invariant` 伴生入口与 `./package.json` 三条解析路径（[packages/code-runtime/code-runtime-python/package.json:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/package.json#L16-L26)）
- `files` 白名单把 `py/**/*.py` 一并纳入发布内容，使 Python 侧镜像随包原样分发（[packages/code-runtime/code-runtime-python/package.json:27-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/package.json#L27-L32)）

### packages/code-runtime/code-runtime-python/py/protocol.py

线协议的 Python 侧词汇镜像，供 CPython 子进程引导代码使用，并被跨语言镜像测试逐字段比对。

- `PROTOCOL_FD = 3` 从子进程视角固定帧通道的文件描述符，stdout/stderr 留给程序自身输出（[packages/code-runtime/code-runtime-python/py/protocol.py:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L22)）
- 携带 `global` 这一 Python 关键字键的帧改用函数式 `TypedDict` 声明，保留真实线上键名（[packages/code-runtime/code-runtime-python/py/protocol.py:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L35)、[packages/code-runtime/code-runtime-python/py/protocol.py:70-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L70-L73)）
- `boot` 帧声明 CPU 秒数、地址空间字节、日志字节预算、完成值字节预算与命名空间列表为必填字段（[packages/code-runtime/code-runtime-python/py/protocol.py:45-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L45-L53)）
- 可选字段帧用「必填基类 + `total=False` 子类」拆分，使 `errorClass`、`truncated`、`value`/`error` 为可选而 `type` 等不可缺（[packages/code-runtime/code-runtime-python/py/protocol.py:38-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L38-L42)、[packages/code-runtime/code-runtime-python/py/protocol.py:76-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L76-L87)、[packages/code-runtime/code-runtime-python/py/protocol.py:98-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L98-L105)）
- `done` 帧的错误 `kind` 限定为 `exception`、`invalid-output`、`output-limit` 三种（[packages/code-runtime/code-runtime-python/py/protocol.py:90-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L90-L95)）
- 子进程侧的入站联合包含 `boot`、`run` 与 `reply` 三类帧（[packages/code-runtime/code-runtime-python/py/protocol.py:125-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L125-L128)）
- `log_truncation_marker` 生成与宿主侧逐字节一致的日志截断标记文本（[packages/code-runtime/code-runtime-python/py/protocol.py:131-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/py/protocol.py#L131-L138)）

### packages/code-runtime/code-runtime-python/src/index.ts

该包的库入口，重导出线协议的类型与宿主侧编解码、校验函数。

- 无运行期机制

### packages/code-runtime/code-runtime-python/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属。

- 导出插件名与 `inject = ['invariants']`，声明该伴生插件在 invariants 服务就绪后才激活（[packages/code-runtime/code-runtime-python/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/invariant.ts#L13-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/code-runtime/code-runtime-python/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/invariant.ts#L22)）
- `apply` 以包名调用 `ctx.invariants.register` 并返回其 disposer（[packages/code-runtime/code-runtime-python/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/invariant.ts#L29-L30)）

### packages/code-runtime/code-runtime-python/src/protocol.ts

宿主侧的 fd-3 线协议实现：帧字段清单、无损 JSON 编码与计量、以及对入站帧的逐字段重建校验。

- `PROTOCOL_FD = 3` 固定帧通道文件描述符，宿主 spawn 时按位置钉住，Python 侧读同一数字（[packages/code-runtime/code-runtime-python/src/protocol.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L18)）
- `WIRE_FRAME_FIELD_ROLES` 逐帧列出每个线上字段并标注 `required`/`optional`，由 `satisfies` 与帧接口的实际可选性绑定（[packages/code-runtime/code-runtime-python/src/protocol.ts:224-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L224-L236)）
- `WIRE_FRAME_FIELDS` 在模块初始化时把角色表投影为每帧排序后的必填/可选键数组，供跨语言镜像比对（[packages/code-runtime/code-runtime-python/src/protocol.ts:247-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L247-L254)）
- `logTruncationMarker` 生成带字节预算数字的截断标记文本，与 Python 侧逐字节一致（[packages/code-runtime/code-runtime-python/src/protocol.ts:266-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L266-L268)）
- `encodeJsonPlain` 用显式任务栈而非递归序列化 JSON 值，字符串走 `JSON.stringify`，数组与对象压入闭合符与逗号任务，深层结构不受调用栈深度限制（[packages/code-runtime/code-runtime-python/src/protocol.ts:286-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L286-L321)）
- `scalarJson` 对超出安全整数范围的整数型 double 用 BigInt 打印精确位数，而非 `String` 的舍入拼写（[packages/code-runtime/code-runtime-python/src/protocol.ts:332-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L332-L337)）
- `jsonStringBytesUpTo` 单遍扫描算出字符串转义后的精确 UTF-8 字节数，逐字符累计并在越过上限时立刻返回 undefined，不物化转义副本（[packages/code-runtime/code-runtime-python/src/protocol.ts:355-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L355-L384)）
- `jsonStringBytesUpTo` 按 `JSON.stringify` 的转义规则计价：七个短转义算 2 字节、其余 C0 控制符算 6、合法代理对算 4、孤立代理算 6、其他 BMP 码点算 3（[packages/code-runtime/code-runtime-python/src/protocol.ts:360-380](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L360-L380)）
- `checkDoneValue` 一次遍历同时计量完成值的紧凑 JSON 字节数与数字无损性，越过 `maxBytes` 即刻判 `over-budget`（[packages/code-runtime/code-runtime-python/src/protocol.ts:417-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L417-L418)、[packages/code-runtime/code-runtime-python/src/protocol.ts:477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L477)）
- 非有限数与负零被记录为非无损但不立即返回，遍历走完仍在预算内才给出 `non-lossless`，使超预算判定与成员次序无关（[packages/code-runtime/code-runtime-python/src/protocol.ts:425](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L425)、[packages/code-runtime/code-runtime-python/src/protocol.ts:429-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L429-L436)、[packages/code-runtime/code-runtime-python/src/protocol.ts:479-481](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L479-L481)）
- 数组按「括号 + 逗号 + 每元素至少 1 字节」的下界在压栈前先行拒绝超预算，避免把元素推入宿主栈（[packages/code-runtime/code-runtime-python/src/protocol.ts:445-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L445-L453)）
- 对象用 `for...in` 加 `Object.hasOwn` 统计自有键数，按每项至少 4 字节的下界先行拒绝，再逐键计量转义后的键长并加冒号（[packages/code-runtime/code-runtime-python/src/protocol.ts:454-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L454-L473)）
- `hasUnsafeIntegerToken` 直接扫描原始 JSON 文本，跳过字符串字面量（并处理反斜杠转义），只对纯整数形式的数字 token 判定（[packages/code-runtime/code-runtime-python/src/protocol.ts:497-520](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L497-L520)）
- 整数 token 解析为 Infinity 直接判为有损；超出安全范围时用 BigInt 双向比较，只有真正舍入的 token 才判有损（[packages/code-runtime/code-runtime-python/src/protocol.ts:521-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L521-L527)）
- `ownValues` 生成器惰性产出对象自有可枚举属性值，避免复制整层值列表（[packages/code-runtime/code-runtime-python/src/protocol.ts:546-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L546-L550)）
- `hasNonLosslessNumber` 用「每嵌套层一个游标」的迭代遍历检测非有限数与负零，既不递归也不按成员数展开栈（[packages/code-runtime/code-runtime-python/src/protocol.ts:572-592](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L572-L592)）
- `validateChildFrame` 对非对象或 null 的入站帧返回 undefined，并按 `type` 分发；未知类型走 default 分支丢弃（[packages/code-runtime/code-runtime-python/src/protocol.ts:604-607](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L604-L607)、[packages/code-runtime/code-runtime-python/src/protocol.ts:653-654](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L653-L654)）
- `boot-ack` 帧被重建为不含任何额外字段的字面量（[packages/code-runtime/code-runtime-python/src/protocol.ts:608-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L608-L609)）
- `log` 帧要求 `text` 为字符串，且只有字面量 `true` 的 `truncated` 才被带入重建结果（[packages/code-runtime/code-runtime-python/src/protocol.ts:610-615](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L610-L615)）
- `call` 帧要求 id 为有限数且非负零、`global` 与 `name` 为字符串，否则整帧丢弃（[packages/code-runtime/code-runtime-python/src/protocol.ts:616-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L616-L623)）
- `call` 帧必须自带 `args` 属性（缺失即丢弃），且其中不得含非无损数字，通过后被逐字段重建（[packages/code-runtime/code-runtime-python/src/protocol.ts:624-633](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L624-L633)）
- `done` 帧的 `value` 原样透传不做遍历；无 `error` 时按 `value` 是否为 undefined 决定是否带上该字段（[packages/code-runtime/code-runtime-python/src/protocol.ts:635-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L635-L644)）
- `done` 帧的 `error` 必须是对象、`message` 为字符串、`kind` 为三个允许值之一，否则整帧丢弃；`value` 与 `error` 并存时两者都被保留（[packages/code-runtime/code-runtime-python/src/protocol.ts:645-651](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L645-L651)）

### packages/code-runtime/code-runtime-python/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、类型输出目录与工程引用。

- 无运行期机制

### packages/code-runtime/code-runtime-python/tsdown.config.ts

该包的打包配置，产出单个 ESM 产物。

- 声明两个入口（index 与 invariant）、输出目录 `lib`、ESM 格式、node 平台与 es2024 目标，决定该包在运行期可被加载的产物文件（[packages/code-runtime/code-runtime-python/tsdown.config.ts:7-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/tsdown.config.ts#L7-L16)）
- 关闭 dts 生成并关闭 clean，构建时不清除既有输出目录内容（[packages/code-runtime/code-runtime-python/tsdown.config.ts:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/tsdown.config.ts#L14-L15)）
