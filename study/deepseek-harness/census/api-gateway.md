---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/api/gateway
---

# packages/api/gateway

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、187 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/api/gateway/README.md

该包的参考文档，用散文描述 Host 侧调度服务与 Client 侧远程端点的行为、限制与已知缺口。

- 无运行期机制

### packages/api/gateway/package.json

包清单，声明该包的入口映射、发布文件与 Client 侧插件装载元数据。

- `main` 与 `types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/api/gateway/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client`、`./types` 与 `./src/*` 分别映射到不同运行期文件，决定各入口可被导入的实际模块（[packages/api/gateway/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/package.json#L16-L35)）
- `dsh.client` 声明 Client 插件注入 typert 注册表与连接包、平台为 `web`、`immediately: true`（[packages/api/gateway/package.json:36-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/package.json#L36-L45)）
- `files` 限定发布进制品包的运行期文件集合（[packages/api/gateway/package.json:50-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/package.json#L50-L56)）
- `dependencies` 把 `ws` 与超时、协议、校验三个工作区包列为运行期依赖（[packages/api/gateway/package.json:58-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/package.json#L58-L63)）

### packages/api/gateway/src/client/index.ts

Client 侧入口，把生成的远程描述符投影成 `remote.<命名空间>` 服务方法，并持有多路复用流客户端与转发事件订阅。

- `inject` 声明该插件在 typert 与 connection 两个服务就绪后才激活（[packages/api/gateway/src/client/index.ts:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L117)）
- `apply` 构造 `ClientRemoteService`，把 `remote` 服务装进上下文（[packages/api/gateway/src/client/index.ts:123-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L123-L125)）
- 构造函数创建事件泵，并把打开逻辑流的回调交给它（[packages/api/gateway/src/client/index.ts:140-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L140-L144)）
- 仅当连接没有进程内 `rpc.open` 时才启动 WebSocket 多路复用客户端（[packages/api/gateway/src/client/index.ts:145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L145)）
- 启动连接循环，并在每次连上时向拥有者上下文发出 `connection/reset`（[packages/api/gateway/src/client/index.ts:148-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L148-L153)）
- 存在 loader 时把连接启动推迟到 `loader.await()` 完成之后（[packages/api/gateway/src/client/index.ts:154-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L154-L156)）
- 注册卸载效果：置位 disposed、停止连接循环、释放事件泵、关闭流客户端（[packages/api/gateway/src/client/index.ts:157-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L157-L162)）
- `$stream` 用当前连接句柄新建一条可重连的单消费者流（[packages/api/gateway/src/client/index.ts:165-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L165-L167)）
- `$mount` 把挂载做成调用方 fiber 的效果，并把挂载与卸载都排进串行队列（[packages/api/gateway/src/client/index.ts:169-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L169-L177)）
- `$on` 把监听器注册到调用方 fiber 的事件泵上（[packages/api/gateway/src/client/index.ts:179-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L179-L184)）
- `openRemoteStream` 无连接时抛错，优先走进程内 `rpc.open`，否则走 WebSocket 多路复用（[packages/api/gateway/src/client/index.ts:187-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L187-L199)）
- `enqueue` 用一条 promise 链串行化所有挂载与卸载变更（[packages/api/gateway/src/client/index.ts:201-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L201-L205)）
- `mountContribution` 先注册描述符集合，再按命名空间分组安装，失败时逆序回滚并撤销注册（[packages/api/gateway/src/client/index.ts:207-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L207-L233)）
- `validateContribution` 拒绝重复的直接/受限方法、已挂载端点、与服务或已有命名空间冲突的命名空间，以及缺严格编解码器的描述符（[packages/api/gateway/src/client/index.ts:235-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L235-L277)）
- `installNamespace` 返回的卸载器逐个失活令牌、abort 在途调用、摘除方法并在空命名空间时销毁（[packages/api/gateway/src/client/index.ts:289-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L289-L312)）
- `createNamespace` 用一个新 fiber 在同一同步窗口内注册 `remote.<命名空间>` 服务并安装整组方法，启动失败即销毁 fiber（[packages/api/gateway/src/client/index.ts:314-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L314-L346)）
- `disposeNamespace` 只在命名空间已空且仍是当前登记项时卸载其 fiber（[packages/api/gateway/src/client/index.ts:348-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L348-L352)）
- `invokeMethod` 先尝试受限变体（调用方上下文能给出身份时），否则直接变体，再否则无身份的受限变体，都没有则抛出未挂载错误（[packages/api/gateway/src/client/index.ts:354-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L354-L381)）
- `invokeSelected` 按描述符 `mode` 分流到流式或一元调用（[packages/api/gateway/src/client/index.ts:383-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L383-L395)）
- `invoke` 调用前后各检查一次挂载令牌，经 `connection.rpc.call('/api', …)` 发出请求，并把载体抛错折成失败结果（[packages/api/gateway/src/client/index.ts:397-420](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L397-L420)）
- `invokeStream` 逐条产出流项，并在令牌失活后抛出未挂载错误（[packages/api/gateway/src/client/index.ts:422-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L422-L438)）
- `prepareInvocation` 校验实参个数（允许末位可选 AbortSignal）、注入受限上下文身份、逐参数走编解码器解析、并把调用方信号与挂载令牌信号合并（[packages/api/gateway/src/client/index.ts:440-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L440-L487)）
- `RemoteNamespaceService.assertMethodAvailable` 拒绝与服务自身字段或原型成员同名的方法（[packages/api/gateway/src/client/index.ts:501-505](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L501-L505)）
- 实例方法 `assertMethodAvailable` 追加检查已存在但未登记的同名属性（[packages/api/gateway/src/client/index.ts:516-521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L516-L521)）
- `install` 用 `Object.defineProperty` 装一个 getter，读取时按当前 fiber 上下文返回绑定了直接/受限记录的调用函数（[packages/api/gateway/src/client/index.ts:539-564](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L539-L564)）
- `remove` 只在令牌匹配时摘除对应变体，两个变体都没了才删除属性（[packages/api/gateway/src/client/index.ts:566-576](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L566-L576)）
- `installMethods` 为每个描述符建挂载令牌并安装直接与受限变体，任一失败即逆序失活并摘除已装部分（[packages/api/gateway/src/client/index.ts:586-620](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L586-L620)）
- `scopedProjection` 从 context 调用或 scope 声明推导受限投影，并在 scope 未选中唯一 lookup 参数时抛错（[packages/api/gateway/src/client/index.ts:636-662](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L636-L662)）
- `requireStrictDescriptor` 与 `requireStrictCodec` 拒绝任一非严格模式的字段编解码器（[packages/api/gateway/src/client/index.ts:664-678](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L664-L678)）
- `parseInput` 用编解码器 schema 解析入参，失败时抛出带 cause 的字段拒绝错误（[packages/api/gateway/src/client/index.ts:680-689](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L680-L689)）
- `withdrawn`、`carrierFailure`、`internalFailure` 把未挂载与载体失败统一成 `internal` 码的失败结果（[packages/api/gateway/src/client/index.ts:691-702](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L691-L702)）
- `normalizeConnectionStream` 依据错误上的标记把进程内载体的失败还原成 `RemoteStreamError` 或 `RemoteStreamCarrierError`（[packages/api/gateway/src/client/index.ts:711-725](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/index.ts#L711-L725)）

### packages/api/gateway/src/client/journal-stream.ts

在可重连远程流之上实现游标、分页与实时追加协调的抽象基类，被需要日志窗口的 Client 领域消费者继承。

- 构造函数用 `$stream` 建流，把 `open` 绑到子类 `follow`，并按是否已接受开场项区分两种结束错误（[packages/api/gateway/src/client/journal-stream.ts:98-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L98-L109)）
- `open` 拒绝重复打开，取首项发布开场窗口后才启动后台消费，失败即销毁底层流（[packages/api/gateway/src/client/journal-stream.ts:149-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L149-L164)）
- `prepend` 按当前游标读历史页、过滤掉不早于窗口首游标的条目，并在与窗口不衔接时发布空 prepend 后抛错（[packages/api/gateway/src/client/journal-stream.ts:171-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L171-L195)）
- `restart` 把重开物理代的请求转给底层流（[packages/api/gateway/src/client/journal-stream.ts:197-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L197-L200)）
- `dispose` 幂等地销毁底层流并等待后台消费结束（[packages/api/gateway/src/client/journal-stream.ts:206-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L206-L216)）
- `consume` 在代号变化时整代替换、遇到第二个开场游标时抛错，其余条目走接受逻辑，未销毁时把异常交给 `failed`（[packages/api/gateway/src/client/journal-stream.ts:218-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L218-L238)）
- `opening` 要求代首项是 `opened` 帧、拒绝落后于已应用尾游标的续接，并在通过后调用 `accept()`（[packages/api/gateway/src/client/journal-stream.ts:248-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L248-L265)）
- `replaceFromOpening` 校验开场页结束于代游标与页内连续性后，更新首尾与续接游标并发布 `replace`（[packages/api/gateway/src/client/journal-stream.ts:267-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L267-L282)）
- `acceptEntry` 丢弃完全重复条目、拒绝部分重叠、遇缺口走整页修复、否则推进游标并发布 `append`（[packages/api/gateway/src/client/journal-stream.ts:284-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L284-L314)）
- `replaceThrough` 边读页边收活跃条目，合并后若未达目标游标则再读一次，仍不达即抛错，成功则发布 `replace`（[packages/api/gateway/src/client/journal-stream.ts:316-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L316-L367)）
- `readPageWhileFollowing` 把页读取与下一条流项竞速，识别代号变更为被取代、把期间到达的条目排队，并区分页错误与流错误（[packages/api/gateway/src/client/journal-stream.ts:369-412](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L369-L412)）
- `awaitReplacementGeneration` 在页读取被中止后持续拉取直到出现新代项，流先结束则抛错（[packages/api/gateway/src/client/journal-stream.ts:414-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L414-L438)）
- `mergeReplacement` 按首游标排序排队条目、跳过重复、拒绝部分重叠、遇缺口返回 undefined（[packages/api/gateway/src/client/journal-stream.ts:440-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L440-L460)）
- `nextResult` 与 `takeNext` 共享同一个待决 `iterator.next()`，避免并发拉取（[packages/api/gateway/src/client/journal-stream.ts:471-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L471-L491)）
- `assertPage` 检查页内相邻条目游标必须紧邻，否则抛出不连续错误（[packages/api/gateway/src/client/journal-stream.ts:511-523](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L511-L523)）
- `entryRange` 拒绝首游标大于尾游标的倒置条目（[packages/api/gateway/src/client/journal-stream.ts:525-532](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L525-L532)）
- `assertPageThrough` 要求页尾游标严格等于请求游标（[packages/api/gateway/src/client/journal-stream.ts:534-539](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/journal-stream.ts#L534-L539)）

### packages/api/gateway/src/client/remote-events.ts

Client 侧转发事件的拥有者，负责把 Host 内部 `$events` 流泵成连接代，并把 Cordis 监听结果回传给 Host。

- 构造时把 `runGeneration` 注册为连接的代来源（[packages/api/gateway/src/client/remote-events.ts:72-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L72-L78)）
- 事件键带一个进程内随机前缀，使转发事件不与普通 Cordis 事件同名（[packages/api/gateway/src/client/remote-events.ts:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L63)）
- `subscribe` 把监听器注册在调用方 fiber 上下文上并返回该次注册的销毁器（[packages/api/gateway/src/client/remote-events.ts:87-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L87-L97)）
- `dispose` 撤销代来源并等待当前代的监听工作静默（[packages/api/gateway/src/client/remote-events.ts:99-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L99-L103)）
- `deliver` 以 `parallel` 分发通知并把监听器异常收进日志而不外抛（[packages/api/gateway/src/client/remote-events.ts:114-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L114-L119)）
- `pumpEvents` 打开 `$events` 逻辑流，要求首项是 ready 帧才调用 `ready(host)` 建立连接代（[packages/api/gateway/src/client/remote-events.ts:122-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L122-L145)）
- 后续帧按类型分流：`cancel` abort 对应投递、`emit` 走通知、`waterfall` 起一个可取消的应答任务（[packages/api/gateway/src/client/remote-events.ts:146-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L146-L167)）
- 代结束时 abort 所有在途投递并等待任务结算，再按结果投递失败、流失败或意外正常结束抛错以让连接重开（[packages/api/gateway/src/client/remote-events.ts:171-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L171-L183)）
- `answer` 用 Agent 上下文适配器解析目标上下文，解析不到时直接回 `next`（[packages/api/gateway/src/client/remote-events.ts:185-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L185-L205)）
- `answer` 把结果通过 `/api` 上的 `$events/result` 一元 RPC 回传，响应不 ok 即抛错（[packages/api/gateway/src/client/remote-events.ts:206-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L206-L221)）
- `dispatchWaterfall` 把 `agent` 与 `signal` 注入请求后跑 waterfall，用私有 symbol 区分 `next`，并拒绝非 JSON 安全的监听结果（[packages/api/gateway/src/client/remote-events.ts:223-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L223-L248)）
- `parseRemoteEventReady` 校验开场帧的精确键集与 `host.home` 类型（[packages/api/gateway/src/client/remote-events.ts:259-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L259-L274)）
- `parseRemoteEventFrame` 逐类型校验帧键集、id 非空、参数 JSON 安全，并禁止请求自带 `agent`/`signal` 字段（[packages/api/gateway/src/client/remote-events.ts:276-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L276-L309)）
- `abortable` 把监听完成与投递生命周期竞速，信号先中止即拒绝（[packages/api/gateway/src/client/remote-events.ts:330-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-events.ts#L330-L342)）

### packages/api/gateway/src/client/remote-stream.ts

单条逻辑远程流的重连生命周期，被 `$stream` 及其上层的快照流与日志流复用。

- `restart` 递增修订号并 abort 当前代，促成一次替换（[packages/api/gateway/src/client/remote-stream.ts:60-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L60-L65)）
- `dispose` abort 逻辑生命周期与当前代，并等待消费者迭代器关闭（[packages/api/gateway/src/client/remote-stream.ts:71-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L71-L83)）
- `[Symbol.asyncIterator]` 只允许一个消费者，第二次取迭代器即抛错（[packages/api/gateway/src/client/remote-stream.ts:86-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L86-L92)）
- `read` 每代新建 abort 控制器并与逻辑生命周期合成信号，产出带代号、信号与 `accept()` 的项（[packages/api/gateway/src/client/remote-stream.ts:99-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L99-L124)）
- `accept()` 只在代与修订号仍匹配时把重试计数清零并标记已接受（[packages/api/gateway/src/client/remote-stream.ts:118-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L118-L122)）
- 代正常结束时按是否已接受开场项调用 `ended(accepted)` 抛出分类错误（[packages/api/gateway/src/client/remote-stream.ts:125-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L125-L127)）
- 只有载体类错误才进入重试路径，其余错误终止流；重试前先通知 `carrierFailed` 再等待（[packages/api/gateway/src/client/remote-stream.ts:128-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L128-L141)）
- 每代退出时 abort 该代控制器，消费者关闭时 abort 逻辑生命周期（[packages/api/gateway/src/client/remote-stream.ts:142-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L142-L155)）
- `waitForRemoteStreamRetry` 在 Host 代仍在时只允许一次立即重试，否则订阅代来源等待下一个可用代（[packages/api/gateway/src/client/remote-stream.ts:159-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L159-L196)）
- `closeRemoteStreamIterator` 调用 `iterator.return?.()` 并吞掉取消期的失败（[packages/api/gateway/src/client/remote-stream.ts:202-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/remote-stream.ts#L202-L210)）

### packages/api/gateway/src/client/snapshot-stream.ts

在可重连远程流之上实现"一次开场快照加若干增量"的消费者，被需要整体替换语义的 Client 领域使用。

- `start` 只启动一次后台消费（[packages/api/gateway/src/client/snapshot-stream.ts:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/snapshot-stream.ts#L39-L44)）
- `restart` 把替换物理代的请求转给底层流（[packages/api/gateway/src/client/snapshot-stream.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/snapshot-stream.ts#L46-L49)）
- `dispose` 标记销毁、销毁底层流并等待消费循环结束（[packages/api/gateway/src/client/snapshot-stream.ts:55-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/snapshot-stream.ts#L55-L59)）
- `consume` 在代号变化时重置快照标志，遇第二个快照或先于快照的增量都抛错（[packages/api/gateway/src/client/snapshot-stream.ts:61-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/snapshot-stream.ts#L61-L81)）
- 快照先 `replace` 再 `accept()`，增量走 `update`；未销毁时把异常交给 `failed`（[packages/api/gateway/src/client/snapshot-stream.ts:70-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/snapshot-stream.ts#L70-L86)）

### packages/api/gateway/src/client/stream-client.ts

浏览器侧多路复用 WebSocket 的持有者，把若干可独立取消的逻辑流复用在一条物理连接上。

- `RemoteStreamError` 保留 Host 上报的错误码与结构化细节（[packages/api/gateway/src/client/stream-client.ts:16-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L16-L34)）
- `RemoteStreamCarrierError` 单独标记可重试的物理载体失败（[packages/api/gateway/src/client/stream-client.ts:36-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L36-L46)）
- `start` 只启动一次后台连接维持循环，已销毁时不再启动（[packages/api/gateway/src/client/stream-client.ts:64-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L64-L69)）
- `open` 生成随机 streamId、等到 socket 后发 `open` 帧，并把项逐条产出（[packages/api/gateway/src/client/stream-client.ts:78-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L78-L106)）
- 收到 `error` 帧时抛出携带 Host 码与细节的 `RemoteStreamError`，`end` 帧则正常返回（[packages/api/gateway/src/client/stream-client.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L106-L111)）
- 提前退出时从流表移除并在 socket 仍开着时补发 `cancel` 帧（[packages/api/gateway/src/client/stream-client.ts:112-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L112-L118)）
- `close` 停止重连、失败所有在途逻辑流与等待者，并以码 1000 关闭 socket（[packages/api/gateway/src/client/stream-client.ts:125-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L125-L140)）
- `connect` 绑定 open/error/message/close 四个监听：连上即唤醒所有等待者，未连上就失败则报载体错误（[packages/api/gateway/src/client/stream-client.ts:142-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L142-L191)）
- `waitForSocket` 在已连时直接返回，否则登记等待者并随调用方信号中止（[packages/api/gateway/src/client/stream-client.ts:193-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L193-L219)）
- `receive` 只接受文本消息，解析后按 streamId 投递；解析失败即失败全部逻辑流并以码 4002 关闭连接（[packages/api/gateway/src/client/stream-client.ts:221-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L221-L233)）
- `lost` 清空当前 socket、失败所有逻辑流并触发重连（[packages/api/gateway/src/client/stream-client.ts:235-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L235-L245)）
- `maintain` 保证同一时刻只有一个重连任务，前一个结束后再排下一个（[packages/api/gateway/src/client/stream-client.ts:247-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L247-L261)）
- `reconnect` 每次失败递增尝试次数、向控制台告警并退避等待后重连（[packages/api/gateway/src/client/stream-client.ts:263-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L263-L281)）
- `backoffDelay` 按 500ms 起、翻倍、上限 10 秒计算并加抖动（[packages/api/gateway/src/client/stream-client.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L11-L14)）
- 退避延时的实际计算取上限的一半加随机一半（[packages/api/gateway/src/client/stream-client.ts:296-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L296-L299)）
- `sleep` 在信号中止时立刻清除定时器并返回（[packages/api/gateway/src/client/stream-client.ts:301-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L301-L311)）
- `StreamInbox` 缓冲帧并支持一次性失败：失败后清空缓冲、后续 push 被忽略、`next()` 抛出该失败（[packages/api/gateway/src/client/stream-client.ts:313-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L313-L340)）
- `remoteStreamUrl` 从 `location.origin`（缺失或为 `null` 时用内部基址）拼出 mux 路径并把协议改成 ws/wss（[packages/api/gateway/src/client/stream-client.ts:342-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L342-L348)）

### packages/api/gateway/src/index.ts

Host 侧入口，提供 `typertGateway` 服务：解析描述符、校验实参、调用业务方法，并拥有远程流路由与转发事件的 Host 半边。

- `Config` 声明心跳间隔字段，取值范围为 1 到定时器上限、默认 30000 毫秒（[packages/api/gateway/src/index.ts:175-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L175-L178)）
- `wireStream` 暴露统一的开流与失败投影入口，供 mux 与进程内载体共用（[packages/api/gateway/src/index.ts:180-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L180-L184)）
- 监听 `internal/service` 事件以作废已缓存的 SRC 端点认领集合（[packages/api/gateway/src/index.ts:199-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L199-L201)）
- 在连接就绪时向 `/api` 注册拦截器，带端点认领判定与调度回调（[packages/api/gateway/src/index.ts:202-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L202-L208)）
- 在连接与 Web 服务器都就绪时注册 mux 路径的升级路由，先做连接层拒绝检查，卸载时注销路由并关闭 mux（[packages/api/gateway/src/index.ts:209-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L209-L233)）
- `registerRemoteEvents` 只接受一个事件来源，启动消费任务，来源异常时关闭所有客户端并撤销注册（[packages/api/gateway/src/index.ts:242-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L242-L268)）
- `claimsEndpoint` 认领 `$events/result`、形如 `<命名空间>/<方法>` 且有严格定义或曾见过的端点，再退到 SRC 认领集合（[packages/api/gateway/src/index.ts:270-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L270-L277)）
- `collectSrcClaims` 遍历所有已注册服务、读取 `typertRemote` 绑定并展开其远程方法标记（[packages/api/gateway/src/index.ts:279-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L279-L294)）
- `invoke` 拒绝流式描述符，反射调用业务方法，并在信号已中止时把业务异常包成取消错误（[packages/api/gateway/src/index.ts:302-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L302-L318)）
- `stream` 拒绝一元描述符、要求返回值可迭代，并包进可取消的流适配（[packages/api/gateway/src/index.ts:325-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L325-L354)）
- `dispatchRpc` 把 `$events/result` 端点单独处理成事件结果回收，其余走一元调用（[packages/api/gateway/src/index.ts:356-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L356-L375)）
- `openWireStream` 把 `$events` 逻辑端点路由到内部事件流，其余转成远程流请求（[packages/api/gateway/src/index.ts:377-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L377-L386)）
- `openRemoteEvents` 只接受恰含一个空 `args` 对象的载荷，来源未注册时报服务不可用（[packages/api/gateway/src/index.ts:388-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L388-L415)）
- 新客户端分配不重复的 clientId、先补发所有在途待答事件，再产出 ready 帧并转入队列迭代，结束时摘除客户端（[packages/api/gateway/src/index.ts:416-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L416-L432)）
- `consumeRemoteEvents` 在已中止时拒绝新的受限事件，并在来源提前正常结束时抛错（[packages/api/gateway/src/index.ts:434-449](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L434-L449)）
- `broadcastRemoteEvent` 校验事件名与参数 JSON 安全后向所有客户端队列推 `emit` 帧（[packages/api/gateway/src/index.ts:451-459](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L451-L459)）
- `startRemoteEvent` 在 Host 上下文识别不出主体时直接以 `next` 结算，并要求识别结果是非空 Agent 身份（[packages/api/gateway/src/index.ts:461-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L461-L473)）
- 受限事件在其 Agent 上下文上挂一个效果，上下文释放即取消该待答事件；挂载失败则以 `next` 结算（[packages/api/gateway/src/index.ts:474-492](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L474-L492)）
- 待答事件登记后绑定请求信号的 abort 监听，已中止即立即取消，否则投递给当前所有客户端（[packages/api/gateway/src/index.ts:493-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L493-L522)）
- `receiveRemoteEventResult` 对已结算或已被取代的投递做幂等丢弃，按结果结算、按拒绝取消、`next` 则等所有投递都回复后才结算（[packages/api/gateway/src/index.ts:531-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L531-L550)）
- `removeRemoteEventClient` 摘除该客户端的全部投递并结束其队列（[packages/api/gateway/src/index.ts:557-561](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L557-L561)）
- `finishRemoteEvent` 释放信号监听与上下文效果，并向所有仍持有该投递的客户端推 `cancel` 帧（[packages/api/gateway/src/index.ts:574-585](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L574-L585)）
- `closeRemoteEvents` 取消所有待答事件并结束所有客户端队列（[packages/api/gateway/src/index.ts:587-592](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L587-L592)）
- `invokeRpc` 把业务返回包成 `{ ok: true, value }` 信封，异常交给失败投影（[packages/api/gateway/src/index.ts:594-604](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L594-L604)）
- `prepareInvocation` 依次做描述符解析、实参精确校验、接收者上下文解析、服务可用性检查与绑定校验（[packages/api/gateway/src/index.ts:606-619](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L606-L619)）
- 参数并行解析后，若描述符声明取消参数则把请求信号（或永不中止信号）追加为末位实参（[packages/api/gateway/src/index.ts:620-622](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L620-L622)）
- 按 `implementation` 或方法名取出接收者上的函数，取不到即报方法不可用（[packages/api/gateway/src/index.ts:623-632](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L623-L632)）
- `resolveDescriptor` 优先用严格定义，曾见过但已撤回的端点直接失败，其余落到 SRC 推导（[packages/api/gateway/src/index.ts:635-646](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L635-L646)）
- `resolveSrcDescriptor` 扫描所有服务收集候选，零候选与多候选分别报无此端点与端点歧义（[packages/api/gateway/src/index.ts:648-674](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L648-L674)）
- `srcDescriptor` 从方法签名读参数名，要求 `signal` 只能是最后一个参数（[packages/api/gateway/src/index.ts:676-695](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L676-L695)）
- 每个业务参数按名匹配 lookup 定义，多重匹配或线上字段重名都报签名非法，未匹配的按 JSON 参数处理（[packages/api/gateway/src/index.ts:696-729](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L696-L729)）
- context 型调用要求 Host 上下文提供者存在且其线上字段不与参数冲突（[packages/api/gateway/src/index.ts:731-755](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L731-L755)）
- SRC 描述符全部字段的编解码器为 `src-json` 模式（[packages/api/gateway/src/index.ts:757-769](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L757-L769)）
- `resolveReceiverContext` 对 context 型调用校验提供者存在、线上字段与类型符号一致，解析身份得到接收上下文，解析失败或未命中各有专门错误码（[packages/api/gateway/src/index.ts:771-817](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L771-L817)）
- `resolveParameter` 对缺失的 JSON 字段返回 undefined，其余先解码再按需走 lookup 提供者（[packages/api/gateway/src/index.ts:819-840](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L819-L840)）
- lookup 参数校验提供者可用性与线上字段/类型符号一致性，解析异常保留 `TypertLookupFailure`，未命中报 not-found（[packages/api/gateway/src/index.ts:841-880](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L841-L880)）
- `RemoteEventQueue` 用拉取式缓冲，关闭后忽略推入，迭代随信号中止而结束（[packages/api/gateway/src/index.ts:888-920](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L888-L920)）
- `assertRemoteEventFrame` 与 `assertRemoteEventName` 要求事件名非空字符串、参数为 JSON 安全数组（[packages/api/gateway/src/index.ts:922-933](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L922-L933)）
- `parseRemoteEventResultPayload` 要求载荷是恰含一个 `args` 字段的纯对象后再走结果解析（[packages/api/gateway/src/index.ts:935-943](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L935-L943)）
- `remoteRequest` 把端点拆成命名空间与方法，并要求载荷恰含一个纯对象 `args` 字段（[packages/api/gateway/src/index.ts:945-960](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L945-L960)）
- `cancellableStream` 把每次 `next()` 与中止竞速，中止时抛取消错误，并在退出时调用 `iterator.return?.()`（[packages/api/gateway/src/index.ts:968-995](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L968-L995)）
- `rpcFailure` 把取消映射为 `cancelled` 码、保留查找与远程业务失败的原始 failure，其余一律折成 `internal` 且细节为空（[packages/api/gateway/src/index.ts:997-1018](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L997-L1018)）
- `validateBinding` 与 `readBinding` 要求服务上的 `typertRemote` 绑定自指、服务键与命名空间都一致（[packages/api/gateway/src/index.ts:1028-1068](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L1028-L1068)）
- `originalOf` 透过 Cordis 的 original 符号取到未被代理的服务实例（[packages/api/gateway/src/index.ts:1070-1073](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L1070-L1073)）
- `methodParameterNames` 沿原型链找到方法、用源码文本切出参数列表，并拒绝解构、默认值、剩余参数与重名（[packages/api/gateway/src/index.ts:1075-1117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L1075-L1117)）
- `assertExactArguments` 要求 args 是纯对象、无多余字段，且只有声明可省的 JSON 参数与 SRC 参数允许缺失（[packages/api/gateway/src/index.ts:1119-1145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L1119-L1145)）
- `decode` 对严格编解码器先 schema 解析，再统一做 JSON 安全断言，失败折成 `input-invalid` 并带字段名（[packages/api/gateway/src/index.ts:1147-1169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L1147-L1169)）
- `assertJsonValue` 递归拒绝非有限数、循环引用、稀疏或带符号的数组、非纯对象与非数据属性（[packages/api/gateway/src/index.ts:1171-1204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L1171-L1204)）
- 默认导出网关服务类，使其可作为 Cordis 服务插件被装载（[packages/api/gateway/src/index.ts:1216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L1216)）

### packages/api/gateway/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包名并声明没有可检查的运行期不变量。

- `name` 与 `inject` 决定伴生插件的名称与其在 invariants 服务就绪后才装载（[packages/api/gateway/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/invariant.ts#L12-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/api/gateway/src/invariant.ts:17-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/invariant.ts#L17-L22)）
- `apply` 向 invariants 服务登记包名并返回该登记的销毁器（[packages/api/gateway/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/invariant.ts#L29-L30)）

### packages/api/gateway/src/stream-protocol.ts

远程流与事件结果的线上消息定义与解析，被 Host 入口、Client 事件泵与流客户端共同引用。

- 固定 mux 路径 `/api/remote.mux` 与内部 `$events`、`$events/result` 端点名（[packages/api/gateway/src/stream-protocol.ts:5-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L5-L12)）
- 固定开流载荷 `{ args: {} }` 与 ready 帧判别式（[packages/api/gateway/src/stream-protocol.ts:14-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L14-L18)）
- `parseRemoteEventResult` 要求结果恰含三个字段、id 合法，并按 `next`/`result`/`rejected` 三种精确键集分别校验（[packages/api/gateway/src/stream-protocol.ts:96-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L96-L137)）
- `projectRemoteEventRequest` 要求请求直接携带受限 Agent、剥掉 `agent` 与 `signal` 字段、拒绝非字符串或不可枚举属性与非 JSON 安全数据（[packages/api/gateway/src/stream-protocol.ts:139-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L139-L172)）
- `projectRemoteEventRejection` 把任意拒绝值压成 name/message，并只在 JSON 安全时保留 code 与 details（[packages/api/gateway/src/stream-protocol.ts:174-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L174-L191)）
- `restoreRemoteEventRejection` 用线上字段重建 Error 并挂回 name、code、details（[packages/api/gateway/src/stream-protocol.ts:193-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L193-L204)）
- `isRemoteJsonValue` 判定值能否无损穿过 JSON 传输（[packages/api/gateway/src/stream-protocol.ts:206-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L206-L213)）
- 三个 id 谓词在线上边界只接受非空字符串（[packages/api/gateway/src/stream-protocol.ts:215-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L215-L240)）
- `parseRemoteStreamClientMessage` 只接受精确键集的 `cancel` 与 `open` 请求且 streamId、endpoint 非空（[packages/api/gateway/src/stream-protocol.ts:265-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L265-L284)）
- `parseRemoteStreamServerMessage` 只接受 `item`（value 可缺省）、`end` 与结构完整的 `error` 三种帧（[packages/api/gateway/src/stream-protocol.ts:286-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L286-L313)）
- `parseMessage` 先做 JSON 解析并要求顶层是对象，否则抛出对应错误（[packages/api/gateway/src/stream-protocol.ts:315-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L315-L324)）
- `parseRemoteEventRejection` 要求 name 非空、message 为字符串，code 与 details 可选且 details 必须 JSON 安全（[packages/api/gateway/src/stream-protocol.ts:347-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L347-L363)）
- `visitJsonValue` 递归拒绝非有限数、负零、循环引用、被改造过的数组、非纯对象、符号键与不可枚举属性（[packages/api/gateway/src/stream-protocol.ts:381-407](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-protocol.ts#L381-L407)）

### packages/api/gateway/src/stream-server.ts

网关侧的 WebSocket 复用服务端，把一条物理 socket 上的多条逻辑流握手、分发、取消与关闭全部拥有；由网关的连接适配层在 HTTP upgrade 时调用。

- `RemoteStreamMuxServer` 持有一个 `noServer` 模式的 `WebSocketServer`、一组未完成连接的 Promise 与一个心跳定时器句柄（[packages/api/gateway/src/stream-server.ts:23-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L23-L26)）
- 构造函数把流分发器 `open`、错误到线上失败值的映射器 `failure`、心跳间隔毫秒数存为实例私有字段（[packages/api/gateway/src/stream-server.ts:33-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L33-L37)）
- `handleUpgrade` 把已通过鉴权的 upgrade 请求、socket 与残留字节交给 ws 完成握手，握手回调里启动心跳、为该 socket 建一个连接对象并运行，把它的完成 Promise 加入集合、结束后移除（[packages/api/gateway/src/stream-server.ts:45-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L45-L53)）
- `close` 先清掉心跳定时器，再对所有客户端 socket 调 `terminate()`，等 `server.close` 回调，最后等所有连接的完成 Promise（[packages/api/gateway/src/stream-server.ts:56-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L56-L67)）
- `startHeartbeat` 只建一个定时器，周期性对处于 `OPEN` 的 socket 发 Ping 控制帧，并对定时器调 `unref()`（[packages/api/gateway/src/stream-server.ts:70-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L70-L78)）
- 连接对象用一个 Map 记录 streamId 到活动流，用 `writes` 串起所有待写 Promise（[packages/api/gateway/src/stream-server.ts:87-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L87-L88)）
- `run` 监听 `close` 解决关闭 Promise、监听 `error` 时直接 `terminate()`、收到二进制消息用状态码 1003 关闭、消息解析抛错时用状态码 1008 关闭（[packages/api/gateway/src/stream-server.ts:96-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L96-L111)）
- socket 关闭后对全部仍在册的流调 `abort` 并带上 socket 已关闭的错误，再等它们各自的 `done`（[packages/api/gateway/src/stream-server.ts:112-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L112-L116)）
- `receive` 解析出的 `cancel` 消息对应地 abort 该 streamId 的控制器并返回（[packages/api/gateway/src/stream-server.ts:118-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L118-L123)）
- 重复的 streamId 抛错，从而由消息回调把连接以 1008 关闭（[packages/api/gateway/src/stream-server.ts:124-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L124-L126)）
- 新的 open 请求建一个 `AbortController`、把活动流登记进 Map、启动 `pump`、并在 pump 无论成败结束后把该 streamId 从 Map 删除（[packages/api/gateway/src/stream-server.ts:127-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L127-L137)）
- `pump` 用 endpoint、payload 与该流的 abort 信号调 `open` 取到异步可迭代对象，对每个值发一帧 `item`，迭代自然结束且未被 abort 时补发一帧 `end`（[packages/api/gateway/src/stream-server.ts:145-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L145-L150)）
- `pump` 捕获到异常时，若未被 abort 且 socket 仍 `OPEN`，用 `failure` 映射后发一帧 `error`；该终结帧本身发不出去就用状态码 1011 关闭整条连接（[packages/api/gateway/src/stream-server.ts:151-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L151-L161)）
- `send` 先 `JSON.stringify`，序列化失败直接返回 rejected Promise 并附 cause（[packages/api/gateway/src/stream-server.ts:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L164-L170)）
- `send` 把每次写挂在 `this.writes` 之后形成串行写队列，写前检查 socket 是否 `OPEN` 否则 reject，并按 `socket.send` 回调的 error 决定 resolve 还是 reject，同时把吞掉错误的版本存回 `writes`（[packages/api/gateway/src/stream-server.ts:171-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L171-L182)）
- `rawText` 把 ws 的三种 `RawData` 形态（Buffer 数组、ArrayBuffer、Buffer）统一解成 utf8 字符串（[packages/api/gateway/src/stream-server.ts:186-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L186-L190)）
- `rejectRemoteStreamUpgrade` 不把 socket 交给 ws，直接手写一段 401 或 403 的 HTTP 响应（含 `Connection: close`、Content-Type、Content-Length 与小写 body）并 `end`（[packages/api/gateway/src/stream-server.ts:197-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L197-L208)）

### packages/api/gateway/src/types.ts

网关的请求、服务、错误码与事件源契约的类型模块，被网关实现与各连接适配器引用。

- 无运行期机制

### packages/api/gateway/tsconfig.json

包根的 solution-only TypeScript 配置，`files` 为空，只引用 Host 与 Client 两个 face 的叶子配置。

- 无运行期机制

### packages/api/gateway/tsdown.config.ts

包的 tsdown 打包配置，默认导出交给 `packages/client/tsdown.client.ts` 的共享预设生成。

- 默认导出把包名与两个 Node 半边入口 `lib/types/index.js`、`lib/types/invariant.js` 交给 `clientBundle`，由它按 `DSH_BUILD_FACE` 选出该轮要产出的 Node 库配置与浏览器 bundle 配置（[packages/api/gateway/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/tsdown.config.ts#L1-L3)）
