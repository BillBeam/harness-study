---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/code-runtime/code-runtime-worker-thread
---

# packages/code-runtime/code-runtime-worker-thread

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、103 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/code-runtime/code-runtime-worker-thread/README.md

包 README，说明这个后端如何在一个新建 worker 线程中执行 TypeScript 程序、有哪些配置上限与失败取值，供组合者与维护者阅读。

- 无运行期机制

### packages/code-runtime/code-runtime-worker-thread/package.json

包清单，声明这个 worker 线程后端的入口、子路径导出与发布文件白名单。

- `exports` 声明三个入口：根入口、`./invariant`、以及 `./worker` 指向 `./lib/worker.cjs`（[packages/code-runtime/code-runtime-worker-thread/package.json:16-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/package.json#L16-L30)）
- `files` 白名单只发布 `lib/index.js`、`lib/invariant.js`、`lib/worker.cjs` 与类型声明，运行期 spawn 所需的 worker 产物必须在其中（[packages/code-runtime/code-runtime-worker-thread/package.json:31-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/package.json#L31-L36)）

### packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts

worker 侧的执行逻辑，写成对注入 port 的普通函数，由 `worker.ts` 在真实 worker 线程里调用。

- 在模块加载时捕获 `Error`、`Object.create`、`Object.defineProperty`，后续都用捕获值而非当前全局（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L13-L15)）
- `defineBindingErrorField` 用 null 原型描述符在错误对象上定义可枚举字段（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:18-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L18-L23)）
- `LogBuffer` 以空 JSON 数组的 2 字节起算，每条按序列化字节加分隔符计入预算（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:50-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L50-L64)）
- `push` 在预算耗尽时置 `truncated`、只投递能装下的前缀、调用一次 `onLimit`，此后所有文本被丢弃（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:70-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L70-L92)）
- `remainingOutputBytes` 把日志用掉后的剩余字节交给完成值/失败消息的计量（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:95-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L95-L97)）
- console 垫片只有 `log`/`info`/`warn`/`error`/`debug` 五个方法，挂在 null 原型对象上（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L101)）
- 垫片把非字符串参数用 `util.inspect` 渲染、以空格拼接后推入日志缓冲（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:112-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L112-L120)）
- `captureStreamWrites` 替换流的 `write` 槽位，把写入转成日志条目、恒返回 `true`，并在微任务中回调，返回还原函数（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:134-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L134-L150)）
- inspect 选项固定为深度 4、数组 100 项、字符串 10000 字符（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L153)）
- `prepareCompletion` 对 `undefined` 返回空片段，非无损 JSON 转成 `invalid-output`，超出剩余预算转成 `output-limit`，否则编码为线格式（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:166-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L166-L190)）
- `outputLimit` 只发固定的溢出诊断，不携带被拒绝的可变字节（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:193-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L193-L195)）
- `prepareFailure` 先按剩余预算计量失败消息，装不下就换成固定溢出片段（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:198-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L198-L206)）
- `prepareException` 取 `stack` 或 `message`，渲染失败时回落到固定文本（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:216-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L216-L229)）
- `makeBindingErrorClass` 生成继承捕获 `Error` 的类，构造时写入声明的类名与成员名字段（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:245-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L245-L255)）
- `bindingFailure` 在有声明类时用它构造拒绝，否则用捕获 `Error`（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:258-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L258-L260)）
- `makeBindingErrorClasses` 每个命名空间只建一次类，使调用拒绝与 `instanceof` 共享构造器身份（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:267-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L267-L275)）
- `wireReplies` 按 id 取出待决调用并删除，`ok` 时解码（解码失败则拒绝），否则用回复消息拒绝；未知 id 的回复被忽略（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:286-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L286-L299)）
- `makeNamespaces` 为每个命名空间建 null 原型对象，把每个声明名字定义为自有可枚举的异步桥接函数（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:322-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L322-L327)）
- 桥接函数先对参数取无损 JSON 快照，取不到就在发消息前直接拒绝（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:328-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L328-L337)）
- 每次调用自增共享 id 计数器、把 resolve/reject 存入 pending，再 `postMessage` 一条 `call`；postMessage 抛出时删除 pending 并拒绝该调用（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:338-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L338-L353)）
- `runWorkerMain` 用 boot 数据的 `maxOutputBytes` 建缓冲，日志逐条以 `log` 帧、越界以 `output-limit` 帧发往宿主（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:374-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L374-L378)）
- 接管传入的 stdout/stderr 写入，并装配回复路由与从 1 开始的调用 id（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:379-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L379-L387)）
- 收集声明了错误类的命名空间，作为额外的程序可见全局参数（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:388-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L388-L397)）
- 通过异步函数构造器把程序体建成参数为各命名空间全局、错误类与 `console` 的函数，并在体前加 `'use strict'`（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:404-412](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L404-L412)）
- 程序正常返回走完成片段、抛出走异常片段，最终只 `postMessage` 一条 `done`（[packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts:412-423](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/bootstrap.ts#L412-L423)）

### packages/code-runtime/code-runtime-worker-thread/src/index.ts

插件入口：定义 `Config`、注册 `codeRuntime` 服务类，并驱动每次运行的 worker 生命周期与输出账本。

- 事件循环利用率采样间隔固定为 25 毫秒（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L63)）
- 输出上限的下界固定为 4 字节（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L66)）
- 绑定全局名必须匹配不含 `$` 的标识符正则（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L73)）
- 程序被包进异步函数体后再做类型剥离，使顶层 `await`/`return` 合法（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L84)）
- worker 入口路径按自身 URL 路径名后缀在 `./worker.ts` 与 `./worker.cjs` 间二选一，并转成文件系统字符串（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L106)）
- `waitForPipeDrain` 等待管道 `end`/`close`/`error` 之一，并在注册后重查一次状态（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:114-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L114-L131)）
- `parseWorkerMessage` 对入站消息逐字段校验并重建，形状不符返回 `undefined` 被丢弃（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:142-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L142-L165)）
- `done` 帧的 `error.kind` 只接受 `exception`/`invalid-output`/`output-limit` 三种取值（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:155-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L155-L162)）
- `OutputLedger.admit` 按序列化字节加分隔符逐条计入日志，越界返回 false（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:169-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L169-L184)）
- `success` 把完成值计入合并上限，超出则转成 output-limit 结果（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:186-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L186-L190)）
- `failure` 把失败消息计入合并上限，超出时 output-limit 优先（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:192-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L192-L196)）
- `limit` 先给固定诊断留出字节，再按剩余预算保留尽量多的整条日志与最后一条的可容前缀（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:199-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L199-L228)）
- `Config` 模式给出四个上限的默认值：60000、600000、67108864、512（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:239-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L239-L244)）
- 服务对外声明 `language = 'typescript'` 与 `isolation = 'worker-thread'`（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:246-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L246-L247)）
- 构造时逐字段要求配置为有限正数，否则抛出（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:258-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L258-L260)）
- `maxOutputBytes` 必须是不小于 4 的安全整数（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:261-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L261-L263)）
- `maxWallMs` 超过定时器最大延迟时在加载期抛出（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:267-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L267-L269)）
- 通过 `ctx.effect` 注册拆解回调（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L270)）
- 拆解时置 `disposed`、把所有在飞运行以 `abort` 结算，并等待每个 worker 退出（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:278-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L278-L283)）
- `run` 在已拆解时抛出，而不是返回失败结果（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L294)）
- 请求信号已中止时不启动 worker，直接返回 `abort` 失败（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:296-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L296-L298)）
- 剥离后按包装前后缀长度切回程序体，剥离抛出则以 `exception` 失败且不 spawn worker（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:300-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L300-L309)）
- `failureBeforeWorker` 让未起 worker 的失败也走同一套输出账本（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:315-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L315-L317)）
- 绑定全局名非法、命中保留名或重复时抛出（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:322-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L322-L338)）
- 错误类名同样校验标识符、保留名与重名，成员名属性禁止为空、保留成员或双下划线形式（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:341-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L341-L359)）
- boot 数据只携带代码、命名空间全局名与函数名列表、可选错误类声明与输出上限，函数本体留在宿主侧（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:369-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L369-L377)）
- worker 以空环境、空 `execArgv`、配置的堆上限和打开的 stdout/stderr 管道启动（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:378-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L378-L393)）
- 管道字节作为兜底日志计入同一账本，越界时立刻生成 output-limit 终态并覆盖后续结果（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:407-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L407-L418)）
- `finish` 只生效一次：清定时器、摘中止监听、移出在飞集合，然后经一次 `setImmediate` 让已排队的管道字节落地（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:424-435](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L424-L435)）
- 终止 worker 并等待两个管道排空后才计算并 resolve 最终结果（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:436-440](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L436-L440)）
- `done` 帧带 error 时直接落成失败，无 value 时落成无值成功（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:443-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L443-L453)）
- 完成值在宿主侧重新解码，解码失败落成 `invalid-output`（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:454-459](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L454-L459)）
- 绑定调用对同一 id 只应答一次，重复 id 被忽略（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:462-468](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L462-L468)）
- 结算之后的回复不再 `postMessage`（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:469-474](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L469-L474)）
- 函数名只按自有属性查找，非函数时回一条 `unknown binding` 失败（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:475-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L475-L483)）
- 参数解码失败时回失败而不调用绑定（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:484-488](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L484-L488)）
- 绑定结果先取无损 JSON 快照，取不到回失败；绑定抛出/拒绝转成该调用的失败回复而非宿主崩溃（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:489-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L489-L506)）
- 消息监听先解析再分发，日志越界与 `output-limit` 帧都直接把运行落成 output-limit（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:509-526](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L509-L526)）
- worker 的 `error` 与 `exit` 都落成 `worker-exit` 失败并保留已捕获日志（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:527-532](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L527-L532)）
- 周期采样 worker 的事件循环活跃时间，超过 `computeMs` 落成 `timeout`（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:537-542](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L537-L542)）
- 墙钟定时器到期同样落成 `timeout`（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:543-545](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L543-L545)）
- 请求信号中止时落成 `abort` 并带上信号原因（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:546-549](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L546-L549)）
- 每次运行登记进在飞集合，并暴露供拆解调用的 `settle`（[packages/code-runtime/code-runtime-worker-thread/src/index.ts:551-556](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/index.ts#L551-L556)）

### packages/code-runtime/code-runtime-worker-thread/src/invariant.ts

包自有的 invariant 伴生插件，向 invariants 服务登记本包的所有权。

- 声明伴生插件名并注入 `invariants` 服务（[packages/code-runtime/code-runtime-worker-thread/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/invariant.ts#L13-L15)）
- 以空安装器向 `ctx.invariants` 注册包名并返回 disposer（[packages/code-runtime/code-runtime-worker-thread/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/invariant.ts#L21-L29)）

### packages/code-runtime/code-runtime-worker-thread/src/output-json.ts

宿主侧输出账本用的 JSON 字节计量与截断工具，被 `index.ts` 与 `bootstrap.ts` 调用。

- 在模块加载时捕获 `Reflect.apply`、`Buffer.byteLength`、`Object.*`、`String.prototype` 等内建，后续调用都不经过可能被改写的原型（[packages/code-runtime/code-runtime-worker-thread/src/output-json.ts:7-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/output-json.ts#L7-L21)）
- 用 null 原型描述符定义数据属性，避免继承被定义的访问器（[packages/code-runtime/code-runtime-worker-thread/src/output-json.ts:24-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/output-json.ts#L24-L37)）
- `append`/`takeLast` 通过定义索引槽与改写 `length` 代替 `Array.prototype` 方法（[packages/code-runtime/code-runtime-worker-thread/src/output-json.ts:45-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/output-json.ts#L45-L56)）
- `characterAt` 按码点宽度取整字符，避免把代理对切开（[packages/code-runtime/code-runtime-worker-thread/src/output-json.ts:59-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/output-json.ts#L59-L63)）
- `serializedCharacterBytes` 给出引号内每个码点的精确 JSON 字节数：代理对 4、需转义字符 2、孤立代理与其余控制字符 6（[packages/code-runtime/code-runtime-worker-thread/src/output-json.ts:66-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/output-json.ts#L66-L73)）
- `jsonStringBytesUpTo` 边扫边累计，一旦越界立即返回 `undefined`，不构造完整的转义字符串（[packages/code-runtime/code-runtime-worker-thread/src/output-json.ts:81-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/output-json.ts#L81-L91)）
- `jsonValueBytesUpTo` 用显式任务栈迭代遍历 JSON 值并累计分隔符、键与标点字节，越界即中止（[packages/code-runtime/code-runtime-worker-thread/src/output-json.ts:99-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/output-json.ts#L99-L156)）
- `truncateJsonStringBytes` 返回编码后连引号一起能装下的最长码点对齐前缀（[packages/code-runtime/code-runtime-worker-thread/src/output-json.ts:166-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/output-json.ts#L166-L179)）

### packages/code-runtime/code-runtime-worker-thread/src/protocol.ts

宿主与 worker 之间消息词汇的类型声明文件，只有 interface 与 type。

- 无运行期机制

### packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts

worker 侧不依赖其它工作区运行时包的无损 JSON 快照与扁平线格式编解码，宿主与 worker 两侧都调用。

- 在模块加载时捕获 `Function.prototype.toString`、`Reflect.apply`、`Error`、`Set`、`Object.*`、`Number.*` 等内建（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:9-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L9-L35)）
- 用 null 原型描述符定义数据属性，并以 `append`/`takeLast` 绕开数组原型方法（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:38-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L38-L65)）
- Set 的 has/add/delete 都经捕获的原型方法调用（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:68-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L68-L80)）
- `hasIntrinsicConstructor` 用构造器名、prototype 自反与原生源码文本判定内建原型（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:83-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L83-L94)）
- 数组与对象各自要求原型是本 realm 或外部 realm 的内建原型（或 null），否则拒收（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:97-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L97-L118)）
- `enumerableStringKeys` 拒绝任何 symbol 键或不可枚举的自有键（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:121-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L121-L128)）
- `snapshotCodeJsonValue` 以任务栈迭代遍历并逐层复制，不受值的嵌套深度限制（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:150-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L150-L166)）
- 非有限数与负零被拒绝，非对象的其它类型（函数、symbol、undefined）也被拒绝（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:196-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L196-L201)）
- 用活动集合检测循环引用并拒收（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L202)）
- 数组必须原型合法且自有键数恰为 length+1（稀疏或带额外属性即拒收）（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:204-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L204-L215)）
- `encodeWorkerJson` 把值压成先序 token 流，使 structured clone 不必复制应用层嵌套（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:259-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L259-L288)）
- 编码遇到稀疏数组洞或缺失/undefined 的对象属性时抛出（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:271-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L271-L284)）
- `containerToken` 要求容器标记恰有两个约定字段、长度为非负安全整数、键列表为无重复的稠密字符串数组（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:312-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L312-L340)）
- `decodeWorkerJson` 要求入参是非空稠密数组，否则直接拒收（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L351)）
- 解码时容器声明的子项数不得超过剩余 token 数，且多余的根级 token 会使整条拒收（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:357-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L357-L403)）
- 结束时仍有未填满的帧则返回 `undefined`，任何抛出也被吞成 `undefined`（[packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts:415-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker-json.ts#L415-L418)）

### packages/code-runtime/code-runtime-worker-thread/src/worker.ts

真实 worker 线程的入口文件，被宿主以文件路径 spawn。

- 没有 `parentPort` 时抛出而不是脱离宿主继续运行（[packages/code-runtime/code-runtime-worker-thread/src/worker.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker.ts#L12)）
- 把 `parentPort`、`workerData` 与进程的 stdout/stderr 交给 `runWorkerMain` 执行（[packages/code-runtime/code-runtime-worker-thread/src/worker.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/src/worker.ts#L14)）

### packages/code-runtime/code-runtime-worker-thread/tsconfig.json

包的 TypeScript 编译配置与工作区引用。

- 无运行期机制

### packages/code-runtime/code-runtime-worker-thread/tsdown.config.ts

打包配置，决定发布产物的文件与模块格式。

- index 与 invariant 打成 ESM 产物，落在 `lib`（[packages/code-runtime/code-runtime-worker-thread/tsdown.config.ts:9-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/tsdown.config.ts#L9-L18)）
- worker 入口单独打成 CommonJS 产物，与宿主按路径 spawn 的 `lib/worker.cjs` 对应（[packages/code-runtime/code-runtime-worker-thread/tsdown.config.ts:19-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-worker-thread/tsdown.config.ts#L19-L28)）
