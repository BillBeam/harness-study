---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/storage/storage-domain
---

# packages/storage/storage-domain

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、58 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/storage/storage-domain/README.md

包的说明文档，描述域数据形态的用法、路由配置字段、失败码与实现要点，供宿主与维护者阅读。

- 无运行期机制

### packages/storage/storage-domain/package.json

包清单，声明入口、导出映射与发布文件集。

- `exports` 暴露三个入口：根入口指向 `lib/index.js`、`./invariant` 指向 `lib/invariant.js`，另有 `./src/*` 直通源码与 `./package.json`（[packages/storage/storage-domain/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/package.json#L16-L27)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/storage/storage-domain/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/package.json#L28-L32)）
- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/storage/storage-domain/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/package.json#L14-L15)）

### packages/storage/storage-domain/src/domain.ts

一个已打开域的运行期实现：内存态、单条写链、变更事件发射；由 `src/index.ts` 的设施构造，表句柄类在同文件内。

- 构造函数用 `TableHost` 把入队、可读断言、事件发射交给表句柄，并按传入的记录映射为每个表建一个 `KvTableImpl`（[packages/storage/storage-domain/src/domain.ts:177-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L177-L186)）
- 声明了 global 时保存初始值并建立句柄：`get()` 先断言可读再返回内存值（[packages/storage/storage-domain/src/domain.ts:187-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L187-L193)）
- `global.set` 入队后先 `unit.setGlobal` 落盘、再改内存、再发 `domain/changed`，事件的 table 与 key 都是空串（[packages/storage/storage-domain/src/domain.ts:194-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L194-L198)）
- 未声明 global 时访问 `global` 抛出错误（[packages/storage/storage-domain/src/domain.ts:204-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L204-L209)）
- `table(name)` 对未声明的表名抛出错误，已声明的返回同一个稳定句柄（[packages/storage/storage-domain/src/domain.ts:217-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L217-L223)）
- `close()` 把关闭过程记在 `disposal` 上，重复调用共用同一次拆卸（[packages/storage/storage-domain/src/domain.ts:231-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L231-L234)）
- `runClose` 先置 `disposing` 拒绝新写、再等写链排空、再关 unit、置 `closed`、最后调 `onClosed` 释放域名（[packages/storage/storage-domain/src/domain.ts:236-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L236-L244)）
- `emitChanged` 把 `ctx.emit('domain/changed', …)` 包在 try 里，监听器同步抛出只记一条 warn，不回退已提交的写（[packages/storage/storage-domain/src/domain.ts:251-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L251-L261)）
- `enqueue` 在 `disposing` 时直接以 `DomainError('closed')` 拒绝，否则把 job 接到 `chain` 尾部并用 `then(noop, noop)` 让链尾恒定完成（[packages/storage/storage-domain/src/domain.ts:263-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L263-L270)）
- `assertReadable` 在 `closed` 后让所有读抛 `DomainError('closed')`（[packages/storage/storage-domain/src/domain.ts:272-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L272-L276)）
- 表的 `get` 同步读内存映射，先做可读断言（[packages/storage/storage-domain/src/domain.ts:287-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L287-L290)）
- `entries`/`keys` 先把映射展开成数组再返回迭代器，迭代期间的排队写不影响这次遍历（[packages/storage/storage-domain/src/domain.ts:292-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L292-L300)）
- `size` 读内存映射大小，同样先断言可读（[packages/storage/storage-domain/src/domain.ts:302-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L302-L305)）
- `put` 入队后先 `unit.putRecord` 落盘、再写内存、再发 put 事件（[packages/storage/storage-domain/src/domain.ts:307-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L307-L313)）
- `delete` 在自己的链位上判断记录是否存在，不存在直接返回 false 且不写盘不发事件（[packages/storage/storage-domain/src/domain.ts:315-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L315-L319)）
- 存在时 `delete` 先 `unit.deleteRecord`、再删内存、再发 `operation: 'deleted'` 事件并返回 true（[packages/storage/storage-domain/src/domain.ts:320-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L320-L329)）
- `update` 在链位上对缺失键抛 `DomainError('missing-key')`（[packages/storage/storage-domain/src/domain.ts:333-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L333-L339)）
- `update` 在链位上执行变换函数，落盘后写内存、发 put 事件并返回新值（[packages/storage/storage-domain/src/domain.ts:340-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L340-L345)）
- `emitPut` 组装带域名、表名、键与新值的 put 变更事件（[packages/storage/storage-domain/src/domain.ts:348-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/domain.ts#L348-L356)）

### packages/storage/storage-domain/src/error.ts

域层的错误类与错误码词汇，被 `src/index.ts` 与 `src/domain.ts` 抛出。

- `DomainError` 覆写 `name` 为 `'DomainError'` 并把 `code` 作为只读字段暴露给调用方分支（[packages/storage/storage-domain/src/error.ts:34-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/error.ts#L34-L49)）
- 构造时只有传入 `options.detail` 才挂上 `detail`（表名与键）（[packages/storage/storage-domain/src/error.ts:50-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/error.ts#L50-L52)）

### packages/storage/storage-domain/src/events.ts

`domain/changed` 事件的载荷类型与事件表声明合并，供发射方与监听方共享。

- 无运行期机制

### packages/storage/storage-domain/src/index.ts

插件入口：域设施类、后端路由、配置与在存储枢纽上的挂载。

- `inject = ['storage']` 让插件只在存储枢纽服务就绪后才装载（[packages/storage/storage-domain/src/index.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L44)）
- `Config` 要求 `backend` 为必填字符串，`routes` 为字符串字典且默认空对象（[packages/storage/storage-domain/src/index.ts:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L59-L62)）
- `open` 先查名字预留集合，已占用则抛 `already-open`，否则同步占名（[packages/storage/storage-domain/src/index.ts:101-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L101-L104)）
- 路由解析取 `routes[域名]`，缺省回落到 `config.backend`，再从枢纽取后端（[packages/storage/storage-domain/src/index.ts:106-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L106-L107)）
- 后端没有 `kv` 面时抛 `facet-unsupported`（[packages/storage/storage-domain/src/index.ts:108-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L108-L113)）
- 用 `descriptorOf(spec)` 投影出的描述符打开后端 unit（[packages/storage/storage-domain/src/index.ts:114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L114)）
- `loadAll` 后按 spec 声明的表逐条用该表的 zod schema 校验存量记录，未出现在介质中的表建成空映射（[packages/storage/storage-domain/src/index.ts:116-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L116-L124)）
- 介质里 global 为 `null` 视作从未写过，直接用 spec 的 `initial` 而不落盘；否则用 global schema 校验（[packages/storage/storage-domain/src/index.ts:127-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L127-L132)）
- 构造 `DomainImpl` 并传入 `onClosed` 钩子，拆卸完成后才从 `domains` 与 `reserved` 里删名（[packages/storage/storage-domain/src/index.ts:137-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L137-L141)）
- unit 打开之后的任一步失败都先 `unit.close()` 再抛出（[packages/storage/storage-domain/src/index.ts:146-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L146-L149)）
- 外层 catch 无条件释放名字预留后再重抛（[packages/storage/storage-domain/src/index.ts:150-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L150-L155)）
- `get(name)` 按名字返回仍然打开的域运行时，未打开时返回 undefined（[packages/storage/storage-domain/src/index.ts:165-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L165-L167)）
- `closeAll` 并发关闭设施上所有仍打开的域（[packages/storage/storage-domain/src/index.ts:175-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L175-L177)）
- `parseRecord` 把 zod 校验失败翻译成 `invalid-record`，消息区分 global 与具体表键，并带 `detail` 与 `cause`（[packages/storage/storage-domain/src/index.ts:181-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L181-L192)）
- `apply` 把默认后端名与所有路由目标去重成后端服务键，用 `ctx.inject` 等这些服务都在之后才建设施（[packages/storage/storage-domain/src/index.ts:200-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L200-L206)）
- `ctx.effect` 把设施挂成枢纽上的 `domain` 形态，卸载时先 `closeAll` 再取消挂载（[packages/storage/storage-domain/src/index.ts:208-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L208-L216)）
- 以 `storageDomain` 名字把设施提供到上下文上（[packages/storage/storage-domain/src/index.ts:217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/index.ts#L217)）

### packages/storage/storage-domain/src/invariant.ts

包自带的不变量伴生插件，核对每条 `domain/changed` 与发射域的内存态是否一致。

- `inject = ['invariants']` 让伴生插件等不变量服务就绪后才装载（[packages/storage/storage-domain/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/invariant.ts#L21)）
- 安装器以 `{ global: true }` 监听 `domain/changed`，并从枢纽的 `domain` 形态里按名字取域；取不到就报失败（[packages/storage/storage-domain/src/invariant.ts:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/invariant.ts#L24-L29)）
- 表名为空串的事件走 global 分支，事件值与当前内存 global 不是同一引用即报失败（[packages/storage/storage-domain/src/invariant.ts:30-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/invariant.ts#L30-L35)）
- `deleted` 事件在对应记录仍留在内存时报失败（[packages/storage/storage-domain/src/invariant.ts:37-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/invariant.ts#L37-L46)）
- `put` 事件在内存记录与事件值不同引用时报失败，未知 operation 走 `satisfies never`（[packages/storage/storage-domain/src/invariant.ts:47-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/invariant.ts#L47-L57)）
- 安装器自身声明 `inject: ['storage']`，检查只在枢纽可用时运行（[packages/storage/storage-domain/src/invariant.ts:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/invariant.ts#L59)）
- `apply` 用包名把安装器注册到不变量服务并返回其 disposer（[packages/storage/storage-domain/src/invariant.ts:66-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/invariant.ts#L66-L67)）

### packages/storage/storage-domain/src/spec.ts

域声明词汇：表声明、`defineDomain` 的加载期校验，以及投影到后端 unit 描述符。

- `domainTable` 把 zod schema 包成表声明，键类型只作编译期幻影（[packages/storage/storage-domain/src/spec.ts:71-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/spec.ts#L71-L73)）
- `defineDomain` 对不匹配 `UNIT_NAME_RE` 的域名在模块加载期抛错（[packages/storage/storage-domain/src/spec.ts:88-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/spec.ts#L88-L90)）
- 版本号非非负整数时抛错（[packages/storage/storage-domain/src/spec.ts:91-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/spec.ts#L91-L93)）
- `layout` 存在时在运行期再校验取值必须是 `single` 或 `per-record`（[packages/storage/storage-domain/src/spec.ts:94-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/spec.ts#L94-L101)）
- 每个表名都必须匹配 `UNIT_NAME_RE`，否则抛错（[packages/storage/storage-domain/src/spec.ts:102-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/spec.ts#L102-L106)）
- global schema 若能通过 `null` 就抛错，保住介质上 `null` 作为"从未写过"哨兵的语义（[packages/storage/storage-domain/src/spec.ts:107-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/spec.ts#L107-L112)）
- `descriptorOf` 把 spec 投影成后端描述符：名字、版本、表名数组、`hasGlobal`，`layout` 仅在声明时带上（[packages/storage/storage-domain/src/spec.ts:121-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-domain/src/spec.ts#L121-L129)）

### packages/storage/storage-domain/tsconfig.json

包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
