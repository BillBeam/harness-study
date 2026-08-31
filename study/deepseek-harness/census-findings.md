---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查对照与发现
---

# deepseek-harness 普查对照与发现

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc`。逐文件普查在 [`census/`](census/) 下的 268 个文件里，共 **28241 条证据行**，索引见 [`census-index.md`](census-index.md)。本文件是普查**完成之后**才做的事：先归族计数，再打开 `checklist.md` 做双向对照。

**普查与对照的先后**是刻意的。普查从代码出发、按机制判据枚举，全程没有打开清单；枚举收口后才拿清单来对，所以「仓库有、清单没有」那一节是真残差，不是先看了清单再去找的。

**产物大小。** 本文件控制在 120 KB 以内。第三、六两节的条目数超出预算时按数量截取并在节内注明；**没有把细节下沉进 `census/` 各包文件**——那些文件的证据行数被 `census-index.md` 与本文第一节的族计数同时引用，往里加内容会让两处数字同时失效。

## 一、机制族汇总

27 个机制族，从证据本身归纳，不套用任何预设分类。**每条证据行只进一个族**：归族由逐批 agent 按各族的判别口径做，每个文件的各族条数之和用 `grep -c '^- '` 与该文件实际证据行数核对过。

各族之和 **28241** ＝ 证据总数 **28241**，无差额。

| 机制族 | 一句话作用 | 涉及的包 | 证据行数 | 代表性链接 | 技术点编号 |
| --- | --- | ---: | ---: | --- | --- |
| 无运行期机制的空条目 | 记下这个文件被普查过、但它不贡献任何运行期行为。 | 267 | 905 | — | 清单无 |
| 包清单与构建配置字段 | 用一份被工具读取的声明文件，规定这个包怎么被解析、发布、编译、打包与测试。 | 267 | 1229 | [packages/test-support/session-snapshot/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/session-snapshot/package.json#L16-L27) | 清单无 |
| 组合文件里的插件行 | 一行 YAML 决定装哪个包、给它什么参数、放进哪个 realm、什么平台下不装。 | 15 | 647 | [packages/preset/agent-presets/presets/cordis/agent.cordis.yml:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L45-L47) | 53、54、72 |
| 快照语料与期望钉子 | 一份份钉住的语料：这个场景由清单怎么声明、会话日志该长什么样、模型该读到什么、界面该念出什么。 | 1 | 3125 | [snapshots/acp/cancel-tool-calls/session.jsonl:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/snapshots/acp/cancel-tool-calls/session.jsonl#L1) | 68 |
| 不变量伴生插件的登记与自检 | 每个包附带一份运行期自检，向不变量服务占住自己的包名，多数只登记不检查。 | 248 | 831 | [packages/test-support/session-snapshot/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/session-snapshot/src/invariant.ts#L28-L29) | 清单无 |
| 服务的登记、事件派发与撤销 | 把一个条目放进某张表、交出摘掉它的手，并规定这张表怎么把消息送给它。 | 228 | 2092 | [packages/todo/tool-todo/src/index.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L149-L151) | 5、38、72、77 |
| 作用域链、可见集与纤程生命周期 | 一份插件怎么起来、依赖谁、能看见谁、怎么落下去、怎么被换掉。 | 55 | 486 | [packages/typert/loader/src/index.ts:359-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L359-L365) | 52、72 |
| 取值的来源、默认与择序 | 决定某个值最终等于什么：写死在哪、缺省是什么、多个来源时选谁、缺席时拿什么顶上。 | 220 | 2119 | [packages/todo/tool-todo/src/index.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L26) | 30、53、54、63 |
| 形状校验与拒绝 | 在某个边界上检查一个值的类型、键集、结构与前提，不合规就当场拒绝，而不是接受后再说。 | 195 | 1842 | [packages/todo/tool-todo/src/index.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L41-L43) | 26、31 |
| 失败的归类、错误码与说辞 | 把一次已经发生的失败改写成另一种表示——一个稳定的码、一段文案、一个类别——本身不引入新判据。 | 173 | 1006 | [packages/typert/loader/src/index.ts:429-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L429-L436) | 23、43、66 |
| 取消、单飞与执行节奏 | 在飞的活何时停、几条并行、按什么节奏推进与结算、收尾怎么保证跑到。 | 165 | 1524 | [packages/typert/loader/src/index.ts:411-422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L411-L422) | 18、23、36、56、60 |
| 上限、预算与截断 | 给数据体量定一个数值上限，并规定触到上限之后砍掉什么、换成什么。 | 79 | 420 | [packages/typert/generator/src/cordis-catalog.ts:343-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/generator/src/cordis-catalog.ts#L343-L348) | 7、8、41、57 |
| 缓存、去重、稳定次序与身份铸造 | 让同一件事不重复算、不重复出现、每次顺序都一样，以及为此铸出的键与 id。 | 155 | 844 | [packages/typert/generator/src/analyzer.ts:2523-2528](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/generator/src/analyzer.ts#L2523-L2528) | 12 |
| 路径、说明符与查表分派 | 拿一个说明符、路径、名字或种类，单层算出该落到哪个文件、哪个实现、哪条分支，以及未命中怎么办。 | 121 | 613 | [packages/typert/generator/src/analyzer.ts:3065-3075](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/generator/src/analyzer.ts#L3065-L3075) | 35 |
| 跨协议的编解码与字段搬运 | 在自家结构与某个外部系统、协议或另一套契约之间把数据搬来搬去。 | 113 | 839 | [packages/util/crypto/src/index.ts:20-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/index.ts#L20-L27) | 6、16、17、19、20、21、22、25、45 |
| 持久化的追加、落盘与读回 | 状态怎么落到磁盘或数据库，又怎么被读回来、对齐、修复与恢复。 | 87 | 981 | [packages/todo/tool-todo/src/index.ts:213-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L213-L222) | 46、47、53、65、67 |
| 遍历与折叠出的派生结构 | 沿事件序列、树或图一路走下去，折出条目、行、区间、闭包与可达集，并且不绕回来。 | 135 | 1373 | [packages/todo/tool-todo/src/index.ts:138-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L138-L147) | 10、24、58 |
| 模型可见的文本与工具声明 | 决定模型这一次在上下文里读到哪些字，以及这些字与工具声明是怎么被放进去的。 | 80 | 671 | [packages/todo/tool-todo/src/index.ts:45-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L45-L66) | 1、2、3、4、7、9、14、15、43、61、64 |
| 界面的呈现、交互与人读文案 | 把派生好的数据画成界面，处理点选拖拽滚动焦点，并给出人读的字与数。 | 87 | 2201 | [packages/todo/tool-todo/src/index.ts:224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L224) | 69、71 |
| 准入、裁决与信任边界 | 判定某个调用方有没有资格拿到某个东西、这次调用放不放行，越出那条线要不要先问过人。 | 79 | 542 | [packages/subagent/tool-subagent/src/model-selection.ts:139-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L139-L153) | 11、32、33、34、35、37、38、59、62、64、73、75 |
| 进程与线程的启动、派生与关停 | 本进程怎么被调用起来，以及怎么另起一个进程、线程或浏览器并把它管到收尾。 | 51 | 782 | [packages/util/native-command/src/runner.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/runner.ts#L22-L27) | 34、36、40、55 |
| 受限宿主里的平台替身 | 在浏览器 Worker 这类地方把 Node 与命令行世界重新造一遍：能用的造出来，不能用的造成一调就炸。 | 7 | 450 | [docs/subsystems/code-runtime.md:21-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/docs/subsystems/code-runtime.md#L21-L27) | 34、35、76 |
| 构建期产物的生成与改写 | 在构建或生成时读源码与活运行时，产出可执行产物、类型声明、schema、目录与文档区块，并顺手改写模块形态。 | 10 | 728 | [packages/typert/generator/src/emitter.ts:186-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/generator/src/emitter.ts#L186-L216) | 77 |
| 仓库条款与门禁判定 | 仓库对它自己的规定，以及逐条判定已提交内容是否合规的那些脚本与门。 | 7 | 709 | [packages/subprocess/win32-process/verify/abi-probe.cpp:37-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/verify/abi-probe.cpp#L37-L45) | 3、39 |
| 跨端通道、请求路由与远端方法 | 维持宿主与浏览器或外部客户端之间的那条线，并把一次远端调用送到具体方法与接收者。 | 50 | 575 | [packages/webhook/webhook-github/src/handler.ts:84-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L84-L90) | 71、73、76 |
| 测试替身、回放与逐字比对 | 起真进程或搭起替身跑一遍，把跑出来的东西归一化后与语料逐字比对，必要时写回。 | 9 | 701 | [packages/test-support/session-snapshot/src/suite.ts:1065-1117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/session-snapshot/src/suite.ts#L1065-L1117) | 40、68、69、78 |
| 未归族 | （归族时新增） | 6 | 6 | [packages/web/tool-web/src/index.ts:15-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/index.ts#L15-L18) | 清单无 |

## 二、跨包机制

证据横跨两个以上包的族共 26 个。这里的「包」是普查分组的宿主目录，`_` 前缀的篮（`_root`/`_docs`/`_scripts`/`_snapshots`/`_website`）各算一个。

- **无运行期机制的空条目** —— 905 条证据，跨 267 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`native/landlock-run`、`native/landlock-run/packages/entry`、`native/landlock-run/packages/linux-arm64`、`native/landlock-run/packages/linux-x64`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`，另 253 个
- **包清单与构建配置字段** —— 1229 条证据，跨 267 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`native/landlock-run`、`native/landlock-run/packages/entry`、`native/landlock-run/packages/linux-arm64`、`native/landlock-run/packages/linux-x64`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`，另 253 个
- **不变量伴生插件的登记与自检** —— 831 条证据，跨 248 个包：`docs`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`、`packages/attachment/attachment`、`packages/attachment/attachment-local`、`packages/boot/app-boot`、`packages/boot/cmdline`、`packages/bundle/acp-app`、`packages/bundle/base`、`packages/bundle/headless`，另 234 个
- **服务的登记、事件派发与撤销** —— 2092 条证据，跨 228 个包：`_root`、`apps/cli`、`docs`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`、`packages/attachment/attachment`、`packages/attachment/attachment-local`、`packages/boot/app-boot`、`packages/boot/cmdline`、`packages/bundle/acp-app`，另 214 个
- **取值的来源、默认与择序** —— 2119 条证据，跨 220 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`native/landlock-run`、`native/landlock-run/packages/entry`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/attachment/attachment`、`packages/attachment/attachment-local`、`packages/boot/app-boot`，另 206 个
- **形状校验与拒绝** —— 1842 条证据，跨 195 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`native/landlock-run`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`、`packages/attachment/attachment`、`packages/attachment/attachment-local`、`packages/boot/app-boot`，另 181 个
- **失败的归类、错误码与说辞** —— 1006 条证据，跨 173 个包：`_root`、`apps/cli`、`docs`、`native/landlock-run`、`native/landlock-run/packages/entry`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`、`packages/attachment/attachment`、`packages/attachment/attachment-local`、`packages/boot/app-boot`，另 159 个
- **取消、单飞与执行节奏** —— 1524 条证据，跨 165 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`native/landlock-run`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`、`packages/attachment/attachment-local`、`packages/boot/app-boot`、`packages/bundle/headless`，另 151 个
- **缓存、去重、稳定次序与身份铸造** —— 844 条证据，跨 155 个包：`_root`、`docs`、`native/landlock-run`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/session-controller`、`packages/api/workspace-controller`、`packages/attachment/attachment-local`、`packages/boot/app-boot`、`packages/bundle/web-app`、`packages/client/connection`、`packages/client/locale`、`packages/client/modules`、`packages/client/store`，另 141 个
- **遍历与折叠出的派生结构** —— 1373 条证据，跨 135 个包：`_root`、`apps/web`、`docs`、`packages/acp/acp`、`packages/api/session-controller`、`packages/api/workspace-controller`、`packages/boot/app-boot`、`packages/boot/cmdline`、`packages/bundle/headless`、`packages/client/connection`、`packages/client/locale`、`packages/client/modules`、`packages/client/ui-agent-preset`、`packages/client/ui-chat`，另 121 个
- **路径、说明符与查表分派** —— 613 条证据，跨 121 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`native/landlock-run/packages/entry`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`、`packages/attachment/attachment-local`、`packages/boot/app-boot`、`packages/bundle/web-app`、`packages/client/connection`，另 107 个
- **跨协议的编解码与字段搬运** —— 839 条证据，跨 113 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`native/landlock-run`、`native/landlock-run/packages/entry`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`、`packages/attachment/attachment`、`packages/attachment/attachment-local`、`packages/boot/app-boot`，另 99 个
- **持久化的追加、落盘与读回** —— 981 条证据，跨 87 个包：`apps/cli`、`docs`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/session-controller`、`packages/attachment/attachment`、`packages/attachment/attachment-local`、`packages/boot/app-boot`、`packages/client/connection`、`packages/client/store`、`packages/client/ui-chat`、`packages/client/ui-conversation`、`packages/client/ui-permission-presets`、`packages/client/ui-settings-models`，另 73 个
- **界面的呈现、交互与人读文案** —— 2201 条证据，跨 87 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`packages/api/session-controller`、`packages/boot/app-boot`、`packages/bundle/headless`、`packages/bundle/web-app`、`packages/client/hmr`、`packages/client/locale`、`packages/client/modules`、`packages/client/ui-agent-preset`、`packages/client/ui-approval`、`packages/client/ui-attachment`，另 73 个
- **模型可见的文本与工具声明** —— 671 条证据，跨 80 个包：`apps/cli`、`docs`、`packages/acp/acp`、`packages/boot/app-boot`、`packages/bundle/acp-app`、`packages/bundle/base`、`packages/bundle/headless`、`packages/bundle/sdk-app`、`packages/bundle/sdk-minimal`、`packages/bundle/web-app`、`packages/client/ui-deliverables`、`packages/compaction/compaction-basic`、`packages/context/agent-instructions`、`packages/context/file-reference`，另 66 个
- **上限、预算与截断** —— 420 条证据，跨 79 个包：`docs`、`packages/acp/acp`、`packages/api/session-controller`、`packages/attachment/attachment`、`packages/attachment/attachment-local`、`packages/client/connection`、`packages/client/modules`、`packages/client/ui-chat`、`packages/client/ui-conversation`、`packages/client/ui-deliverables`、`packages/client/ui-input-trigger`、`packages/client/ui-layout`、`packages/client/ui-primitives`、`packages/client/ui-tool`，另 65 个
- **准入、裁决与信任边界** —— 542 条证据，跨 79 个包：`docs`、`native/landlock-run/packages/entry`、`packages/acp/acp`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/boot/app-boot`、`packages/bundle/web-app`、`packages/client/connection`、`packages/client/ui-approval`、`packages/client/ui-deliverables`、`packages/client/ui-renderer`、`packages/client/ui-settings-general`、`packages/client/ui-settings-models`、`packages/compaction/compaction-basic`，另 65 个
- **作用域链、可见集与纤程生命周期** —— 486 条证据，跨 55 个包：`_root`、`apps/cli`、`docs`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/session-controller`、`packages/boot/app-boot`、`packages/bundle/headless`、`packages/client/hmr`、`packages/client/modules`、`packages/client/ui-commands`、`packages/client/ui-conversation`、`packages/client/ui-input-trigger`、`packages/client/ui-reference`，另 41 个
- **进程与线程的启动、派生与关停** —— 782 条证据，跨 51 个包：`_root`、`apps/cli`、`apps/web`、`docs`、`native/landlock-run`、`native/landlock-run/packages/entry`、`packages/boot/app-boot`、`packages/boot/cmdline`、`packages/bundle/acp-app`、`packages/bundle/headless`、`packages/bundle/sdk-app`、`packages/bundle/web-app`、`packages/code-runtime/code-runtime-worker-thread`、`packages/context/tmux-context`，另 37 个
- **跨端通道、请求路由与远端方法** —— 575 条证据，跨 50 个包：`_root`、`docs`、`packages/acp/acp`、`packages/api/gateway`、`packages/api/remotes`、`packages/api/session-controller`、`packages/api/settings-controller`、`packages/api/workspace-controller`、`packages/bundle/web-app`、`packages/client/connection`、`packages/client/hmr`、`packages/client/modules`、`packages/client/ui-agent-preset`、`packages/client/ui-chat`，另 36 个
- **组合文件里的插件行** —— 647 条证据，跨 15 个包：`apps/cli`、`packages/bundle/acp-app`、`packages/bundle/base`、`packages/bundle/headless`、`packages/bundle/sdk-app`、`packages/bundle/sdk-minimal`、`packages/bundle/web-app`、`packages/experimental/agent-team-profile`、`packages/experimental/agent-team-web-profile`、`packages/experimental/inspector`、`packages/extensions/tool-cordis`、`packages/preset/agent-presets`、`packages/subagent/subagent-claude-code`、`packages/subagent/subagent-codex`，另 1 个
- **构建期产物的生成与改写** —— 728 条证据，跨 10 个包：`_root`、`apps/web`、`docs`、`native/landlock-run`、`packages/experimental/webworker-packer`、`packages/experimental/webworker-runtime`、`packages/typert/generator`、`python/sdk-runtime`、`scripts`、`website`
- **测试替身、回放与逐字比对** —— 701 条证据，跨 9 个包：`docs`、`packages/test-support/agent-loop-testkit`、`packages/test-support/client-runtime`、`packages/test-support/llm-mock-server`、`packages/test-support/llm-replay`、`packages/test-support/loader-smoke`、`packages/test-support/session-snapshot`、`scripts`、`snapshots`
- **受限宿主里的平台替身** —— 450 条证据，跨 7 个包：`apps/web`、`docs`、`packages/code-runtime/code-runtime-worker-thread`、`packages/experimental/webworker-runtime`、`packages/extensions/cordis-client-runner`、`packages/extensions/cordis-host-runner`、`packages/extensions/tool-cordis`
- **仓库条款与门禁判定** —— 709 条证据，跨 7 个包：`_root`、`docs`、`native/landlock-run`、`packages/sandbox/sandbox-windows-acl`、`packages/subprocess/win32-process`、`scripts`、`snapshots`
- **未归族** —— 6 条证据，跨 6 个包：`packages/context/session-reference`、`packages/core/agent`、`packages/sandbox/sandbox`、`packages/sdk/protocol`、`packages/session-query/tool-session-query`、`packages/web/tool-web`

## 三、值得单列的东西

本节由**未参与普查、也未读过上面机制族汇总**的独立 agent 写出，输入只有 `census/` 下的证据行。每条的链接逐字抄自证据行。

独立 agent 共挑出 **121** 条，此处列前 50 条（受本文件 120 KB 上限所限）。这 50 条的全文另存一份在 [`census-findings-extra.md`](census-findings-extra.md) 第一节，其余 71 条的工作文件已丢失、保持现有条数不重新生成。

- **模型可见与已记录互为充要** —— 它把「模型看到了什么」和「日志里有什么」写成双向等价，而不是单向的「记得记日志」。（[AGENTS.md:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L111)）
- **每个包都必须有 ./invariant 导出** —— 「没有不变量」也必须写成一份带理由的显式声明，而不是默认缺省。（[packages/AGENTS.md:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L18)）
- **带凭据请求在跟随重定向前失败** —— 一整个目录的智能体指令文件只承载这一条，而且要求的证明对象是「重定向目标未被访问」这件反面事实。（[packages/web/AGENTS.md:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/AGENTS.md#L5)）
- **逐版本豁免依赖发布时长门槛** —— 这条证据同时揭示了存在一道「新发布的包要等一段时间才能装」的供应链闸门，以及它被逐个版本号打开的名单。（[pnpm-workspace.yaml:49-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L49-L75)）
- **每文件 100% 的四项覆盖率阈值** —— per-file 全 100 是极少见的门槛设定，它同时解释了证据层里为何反复出现「带理由的 v8 ignore 注释」和成百行的覆盖率排除清单。（[vitest.config.ts:348-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L348-L356)）
- **沙箱阻断后的最窄提权重试** —— 它明文给出了智能体越过开发期沙箱的操作路径，同时把「产品沙箱」划为不可越过的另一类。（[AGENTS.md:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L88)）
- **客户端产物是自登记的闭包工厂** —— 一条构建配置证据行里藏着浏览器端插件的整套加载模型：产物不是普通 ESM 模块，而是自己向一个全局注册表报到的工厂。（[packages/client/tsdown.client.ts:558-569](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L558-L569)）
- **RPC 参数名切自函数源码文本** —— 线上端点的字段名由 JS 源码中形参的字面名字决定，这把函数源文本本身放进了协议契约。（[packages/api/gateway/src/index.ts:1075-1117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L1075-L1117)）
- **连接另一端裁决 Host 的 waterfall** —— 一条进程内的 Cordis 瀑布链，其中一环被交到连接对端去决定，并给出了断连时的确定回落。（[packages/api/remotes/src/index.ts:139-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L139-L152)）
- **env 文件里被拒的变量名清单** —— 这是一份写死在启动库里的名字与前缀清单，规定了被读取的 env 文件不能设置哪些变量。（[packages/boot/app-boot/src/index.ts:96-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L96-L117)）
- **附件落盘 fsync 到文件系统根** —— 一个图片存储把持久化证明一路做到文件系统根，并用硬链接而非 rename 发布对象。（[packages/attachment/attachment-local/src/store.ts:176-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L176-L183)）
- **按 sec-fetch-dest 分流的文档站** —— 同一个 URL 会因请求方是否带浏览器导航头而返回 HTML 或原始 Markdown。（[website/.vitepress/config.ts:132-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L132-L136)）
- **基础层里的遥测端点** —— 一个具名远端地址与其默认模式写在所有 profile 共享的基础补丁层里，取值只走环境变量。（[packages/bundle/base/cordis.patch.yml:195-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L195-L198)）
- **四种结束原因都译成 end_turn** —— 协议边界上，内部的中止、阻断与出错三种收尾对客户端呈现为同一个终止原因。（[packages/acp/acp/src/codec.ts:27-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/codec.ts#L27-L32)）
- **时钟读数的重放级自检** —— 一个只往上下文里塞三行时钟读数的插件，给自己写出的每条消息配了一套重放校验器，连来源对象的键数都要数。（[packages/context/time-context/src/invariant.ts:111-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L111-L125)）
- **跨会话快照里的 `<` 全部被转义** —— 被引用会话的正文在进入提示词前，连一个 `<` 字符都不被允许原样出现。（[packages/context/session-reference/src/serialization.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/session-reference/src/serialization.ts#L11)）
- **崩溃即让位的槽条目** —— 槽注册表把「渲染时抛错」做成了条目从槽位上退出的一次正式状态转移，而不是一次日志。（[packages/client/ui-slots/src/index.ts:1096-1104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1096-L1104)）
- **与成员次序无关的超预算判定** —— 两类拒绝理由被刻意排了先后，同一个值无论键的遍历顺序如何都会得到同一个结论。（[packages/code-runtime/code-runtime-python/src/protocol.ts:429-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime-python/src/protocol.ts#L429-L436)）
- **不收缩的压缩会被当场拒绝** —— 「压缩之后更小」在这里是事务内的一道硬检查，不通过就整条失败。（[packages/compaction/compaction-basic/src/region.ts:380-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L380-L388)）
- **用小数 seq 插进事件流的合成节点** —— 在一条整数 seq 的持久事件流里，前端直接用小数编号给自己合成的节点占位。（[packages/client/ui-trajectory/src/client/trajectory-assistant-definition.ts:353-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-trajectory/src/client/trajectory-assistant-definition.ts#L353-L365)）
- **ripgrep 启动时强插 --no-config** —— 一个单行 argv 细节承担着「别让环境里的配置文件把搜索变成任意命令执行」这件事，混在近百条搜索工具证据里几乎看不见。（[packages/fs/tool-fs-search/src/search-core.ts:234-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L234-L235)）
- **动态插件沙箱自陈不是安全边界** —— 这是整套「让模型现场写代码并在本进程里跑起来」机制自己对边界强度的陈述，且同一句话既给人读也给模型读。（[packages/extensions/tool-cordis/README.md:182-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L182-L184)）
- **模型写的 UI 渲染进它自己那次工具调用的卡片** —— 模型当场生成的 React 组件被安排在它自己那一次 `cordis_run` 的工具卡片位置上显示，而「self」这个键由守卫改写成运行三元身份。（[packages/extensions/cordis-client-runner/src/client/slot-catalog.ts:2181-2197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/cordis-client-runner/src/client/slot-catalog.ts#L2181-L2197)）
- **跨领域 instanceof 补丁** —— 两条证据一正一反地记下同一件事：模型代码与宿主代码住在两个 JS 领域里，语言的身份判定在这条缝上被手工修补过。（[packages/extensions/cordis-host-runner/src/sandbox.ts:62-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/cordis-host-runner/src/sandbox.ts#L62-L76)）
- **「先读再改」是一个可拆的监听者** —— 读后写这条规则不长在文件工具里，而长在一个独立包的瀑布监听者上——它不被组合进来时，同一个 edit 工具就是无条件写。（[packages/fs/fs-observation-policy/src/index.ts:78-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L78-L83)）
- **自报「卡住了」有最少轮数门槛** —— 同一个授权可以让模型自己宣布目标完成，却不允许它在跑满若干轮之前宣布自己被挡住。（[packages/goal/tool-goal/src/index.ts:299-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L299-L306)）
- **Stop hook 能把已要停的回合推回去** —— 外部命令可以否决一次收尾并让代理继续跑，而载荷里那个用来标识「本轮已由 Stop hook 续过」的字段被写死为 false。（[packages/hooks/hooks-claude-code/src/index.ts:270-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L270-L277)）
- **会话日志随请求上传给官方 API 的 `dsh_session_log` 字段** —— 这是普查里唯一一条把整份会话日志（含头部与原始事件）作为请求字段随模型调用外发的机制，且水位由对端调用 accept 推进。（[packages/session/session-log-deepseek/src/index.ts:83-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L83-L89)）
- **设置脱敏遍历器自陈的可达性缺口** —— 这是一条文档里自己写明的、剥离 `role('secret')` 字段会失效的具体条件，而 `describe(redactSecrets: true)` 正是线上表面使用的那条路径。（[packages/settings/settings/README.md:152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/README.md#L152)）
- **按反馈事件触发的整会话遥测采集** —— 这条把一个用户动作（记录反馈）与「把该会话此前未交付的事件一次性经 OTLP 导出」绑在同一处，是三种遥测模式中唯一由会话内事件触发外发的分支。（[packages/session/session-telemetry-otel/src/index.ts:242-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L242-L252)）
- **会话内检索对当前会话的序号上界压缩** —— 这是一条专门挡住模型检索自己当前这一步内容的边界，且缺少步骤边界时选择报错而不是放行。（[packages/session-query/tool-session-query/src/operations.ts:127-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L127-L136)）
- **用保留噪字符标记数命中数的 FTS5 排序键** —— 排序主键不是 FTS5 的排名函数，而是靠在 SQL 里数自己注入的两个保留字符的字节数得出，靠索引/查询两侧同步清洗保证这两个字符不会自然出现。（[packages/session-query/session-query-sqlite/src/index.ts:828-835](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query-sqlite/src/index.ts#L828-L835)）
- **导入 node:sqlite 期间临时替换 `process.emitWarning`** —— 一个持久化后端为了压掉一条运行时警告而在导入窗口内改写进程级全局函数，是这一组里唯一一处进程级全局改写。（[packages/session/session-persistence-sqlite/src/store.ts:466-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L466-L491)）
- **配置文件里的 `!!js` 标量在插件上下文里被 eval** —— 一条证据就交代了配置文件里存在一类会被求值成任意 JS 的标量，且它的作用域就是插件的 `ctx`。（[vendor/loader/src/config/utils.ts:3-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/utils.ts#L3-L9)）
- **取 Node 内部 ESM 加载器的两条路与两代版本标记** —— 这两行把一个跨 Node 主版本、依赖运行标志与原生插件的私有 API 接入点，压在了一个 vendor 包的单个文件里。（[vendor/loader/src/internal.ts:108-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/internal.ts#L108-L118)）
- **热替换直接备份并删除 ESM 与 CJS 两套模块缓存，失败可回滚** —— 「用 `Map.prototype` 方法绕过版本差异」这一句指明它绕过的是缓存对象自身可能被改写的方法，是直接操作运行时内部结构的写法。（[vendor/hmr/src/index.ts:461-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L461-L469)）
- **靠七种情形排除后才判定「插件自己卸载了自己」** —— 一次插件自我卸载会被写回磁盘上的配置文件变成 disabled，而这个判定完全由七个否定条件拼出来。（[vendor/loader/src/index.ts:125-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L125-L152)）
- **用正则解析 macOS LaunchServices plist 文本取默认浏览器** —— 为了让 `.html`/`.svg` 这类文件走浏览器而不是默认应用，这里去读并用正则拆解了一个系统偏好设置的文本转储。（[packages/util/native-command/src/path-opener.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L37-L42)）
- **自己按位拼 v4 UUID，不调用 `crypto.randomUUID`** —— 这是全仓库铸造请求、会话与附件标识符的那个函数，它明确绕开了平台自带的同名 API。（[packages/util/crypto/src/index.ts:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/crypto/src/index.ts#L33-L34)）
- **文件锁把 `EPERM` 单独拿去 lstat 确认，超时也不破锁** —— 「不删除已有锁」是一句关于遗留锁文件处置的明确取舍，被写在用户设置与凭据存储所依赖的这一个工具包里。（[packages/util/atomic-write/src/index.ts:67-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/atomic-write/src/index.ts#L67-L78)）
- **fixture 传输把整套时序钩子挂在 window.__fxTiming 上** —— 一条证据行就说明浏览器页面上存在一个可从外部驱动的故障注入面，且它与 follow 流「遇到跳号即抛 skipped seq 终止」的检查是同一份代码里的两端。（[packages/client/connection/src/client/fixture.ts:2681](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/connection/src/client/fixture.ts#L2681)）
- **被折叠的轮次过程用 hidden="until-found" 隐藏** —— 折叠态与浏览器原生「查找」之间的这条连接只由这三行承担，Chat 包 520 条证据里再无第二处提到 `beforematch`。（[packages/client/ui-chat/src/client/chat/searchable-hidden.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/searchable-hidden.ts#L21-L22)）
- **缓存命中率会自己加小数位，只为不显示成 100** —— 一条格式化函数的证据行里写着一个专门为「99.99% 不得显示为 100%」而存在的分支，这类细节在两万多条里几乎不会被再次提起。（[packages/client/ui-chat/src/client/chat/token-format.ts:76-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/token-format.ts#L76-L97)）
- **HTTP 请求体上限由图片限额反推，不够就在装载期抛错** —— 这是把另一个包的配置值换算成本包传输层常量、并在两个时刻各校验一次的一条断言，一条行里同时装下了跨包数值约束和它的重跑时机。（[packages/client/connection/src/index.ts:52-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/connection/src/index.ts#L52-L64)）
- **用 process.getActiveResourcesInfo() 数 StatWatcher 当不变量** —— 本组其余包的 invariant 安装器几乎全是空函数，这一条是唯一一条真的去读进程活动句柄来验证卸载彻底性的检查。（[packages/client/hmr/src/invariant.ts:31-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/invariant.ts#L31-L51)）
- **一切进入输入框的外部文本都要剔除一段私用区码点** —— 两条相隔很远的证据行合起来才显出：占位码点既被用作内部坐标系的记号，又被当作必须从外来文本中清掉的字符。（[packages/client/ui-conversation/src/client/input/facade.ts:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L111)）
- **首页内联脚本用「只会抛错的 require」把模块系统自举起来** —— 浏览器端整套模块表的起点被压缩在这一条证据行里，其中「用一个必然抛错的 require 去跑 factory」这一步是自举链条上不可替换的一环。（[packages/client/modules/src/index.ts:490-512](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L490-L512)）
- **文档生成器启动真实运行时来收割工具目录** —— 这不是静态扫描源码得到的目录，而是把生产用的依赖注入容器真启动一遍、再用「所有方法都拒绝」的替身把条件性工具逼出来。（[scripts/gen-tool-catalog.ts:684-695](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L684-L695)）
- **Windows 门禁在 Linux 上用 Wine 跑真实的 win-x64 Node** —— 跨平台门禁没有靠 CI 上的真 Windows 机器，而是在同一台 Linux 上装了一整套 Wine + 真 node.exe 的执行环境。（[scripts/wine-windows-gates.sh:214-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/wine-windows-gates.sh#L214-L220)）
- **安装锁的持有者进程已死时，拒绝自动清理** —— 一个装 git 钩子的 postinstall 脚本，在陈旧锁这件事上选择了停下来要人，而不是自愈。（[scripts/install-lefthook.mjs:450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L450)）

## 四、清单有、仓库没有

78 个技术点逐条判定的结果：**有 39 条、部分 31 条、没有 8 条**。下面是判「没有」的。缺席也是结论，所以每条都写明找过哪里。

### 13. 记忆注入的位置与预算 [Gu][Pyd]

`packages/` 下 50 多个分组里没有任何 memory/recall 包，`ctx` 上没有记忆服务，系统提示的 `FIRST_PARTY_SECTION_ORDER` 里没有记忆段位次，模型可见工具表里也没有记忆读写工具（全仓 grep `memor`/`recall` 只命中 SQLite 的 `:memory:`、`useMemo` 式记忆化与第三方 MCP 指南）。唯一与记忆相关的是 `docs/user/guide/mcp-memory.md`：三份接第三方 memory MCP 服务器的参考配置，明写默认全关、须用 `--patch` 才启用，接进来后只是普通的 `mcp__<serverName>__<tool>` 工具，走工具结果进上下文，既没有专属注入位置也没有预算。仓库里确实存在「注入位置 + 字节预算」这套机制，但它长在指令文件上（agent-instructions 的 `maxBytes` 65536、单文件 `maxSourceBytes` 1048576，超预算的 scope 被挤掉并在文本里发预算通告），不是记忆。

**与清单措辞的冲突**：清单假定存在「记忆」这一层并追问它的注入位置与预算；这个仓库根本不承担记忆，把这件事划到第三方 MCP 服务器一侧，因此「位置」与「预算」两个问题在仓库内无对应物。

### 28. 元模型组合器：把多个模型包成一个（随机、轮转、给定序列），与按任务路由的区别 [mini]

没有把多个模型包成一个的元模型组合器。找过的地方：`ctx.llm` 服务本体（packages/llm/llm/src/index.ts 的适配器注册表、`resolveModel`、`prepareCall`、`adapterStream`）里，一次调用的 `LlmCallConfig` 只带单一 provider+model 标量，`callConfigEquals` 也按单一 provider/model 比较；`registration()` 对未注册 provider 直接抛 `NO_ADAPTER`，没有任何候选轮换或改选逻辑。进程级默认模型服务只存一对必填的 `provider`/`model`（packages/core/agent-default-model/src/index.ts:34-38），不接受列表。全仓 `rg -i "round.?robin|randomModel|shuffle|Math.random"` 在 llm 层只命中 `llm-retry` 的抖动随机数与 web 搜索结果的 round-robin 合并（packages/web/tool-web/src/search.ts:258），都与模型选择无关。

**与清单措辞的冲突**：仓库里存在一个形态相反的东西：`registerAdapter(providers: string[], adapter)` 允许一个适配器承载多条路由，`llm-pi-ai` 就是这样的多提供方网关（零路由时休眠不注册，有路由时首次注册或原子替换整个路由集合，packages/llm/llm-pi-ai/src/index.ts:270-292）。那是「一个适配器对多个具名模型」，与清单说的「多个模型包成一个可调用体」正好反过来；调用方仍必须点名唯一的 provider+model。清单末尾的「与按任务路由的区别」在这里也无从对照：换模型只能靠按 agent／子代理显式给定路由。

### 30. 按模型名做的隐式配置推断：命中什么子串、改了哪些默认、如何覆盖 [mini]

没有按模型名做隐式配置推断。找过的地方：`rg "model(Id)?\.(startsWith|includes|match|test)|startsWith\('(gpt|claude|o1|deepseek|gemini)"` 全仓只命中一个与模型无关的脚本；`rg "includes\(|startsWith\(|endsWith\(" packages/llm packages/core/agent-loop/src packages/compaction` 的结果里，凡涉及模型的都是读已声明的元数据而不是名字，例如 `containsImage && !model.input.includes('image')`（packages/llm/llm-pi-ai/src/adapter.ts:354）、`modelInfo.inputModalities.includes('image')`（packages/llm/llm/src/index.ts:996）、`model?.inputModalities?.includes('image') !== true`（packages/llm/llm-deepseek/src/adapter.ts:457）。所有按模型的差异都走精确 id 查表：pi-ai 的 `modelOverrides` 命中不存在的模型直接拒绝（packages/llm/llm-pi-ai/src/catalog.ts:808-827），压缩的按模型覆盖以 provider 与 model 精确匹配（packages/compaction/compaction-basic/src/config.ts:105-125），DeepSeek 的 `modelInfoFor` 对未登记模型只声明 `text` 模态、上下文窗口取目录值否则取默认值（packages/llm/llm-deepseek/src/adapter.ts:393-409）——这是「查不到就用缺省」，不是「按名字猜」。

**与清单措辞的冲突**：仓库不但没有这种推断，还明文禁止：适配器手册要求需要原生元数据做后续调用的 provider 把最小无损 JSON 投影作为 `finish.replayState` 发出，运行时仅当历史路由与目标路由当前属于同一适配器实例时才传回，「缺少该状态时不得仅凭 provider/模型名推断原生重放」（docs/cookbook/adding-an-llm-adapter.md:33）。清单问的「命中什么子串、改了哪些默认、如何覆盖」三问在这里都落空：没有子串、按模型的默认全部来自显式目录或配置、覆盖方式是改那份目录（`models` 整体替换或 `modelOverrides` 逐项套用）。

### 37. 破坏性动作的识别与拦截 [Osm]

没有对「破坏性动作」本身的识别与拦截。在证据层用 破坏/destructive/rm -rf/危险命令/dangerous 全量搜过 268 个普查文件，产品代码零命中；回到仓库对 packages/ 全文搜 rm -rf / destructive / dangerou，命中只有三类：`dangerouslySetInnerHTML`（前端渲染）、`danger-full-access` 与 `dangerously-bypass-approvals-and-sandbox`（沙箱/审批档位名）、以及测试文件（packages/core/agent-loop/tests/interception.spec.ts 里演示一个插件如何在 pre-step 拦下含 `rm -rf` 的提示、在 PreToolUse 按名字拒绝一个叫 danger 的工具）——即拦截 rm -rf 是测试里示范的用户可写扩展，不是仓库出厂的机制。也没有 MCP 风格的工具注解可依据：全仓搜 readOnlyHint/destructiveHint/idempotentHint/openWorldHint 零命中，工具唯一的行为分类是 `executionMode`（可并行/独占），与破坏性无关。这个仓库处理同一风险的办法是不区分动作、只区分权限档：`sandboxPolicy` 的 read-only / workspace-write / danger-full-access 三档配 `ctx.approval` 的 ask 策略与 `ctx.tools.guard()` 单调守卫；升级到更宽档位要走审批（理由文本 `escalate sandbox to <mode>: <justification>`），拒绝/取消/无审批通道都各抛固定错误。

**与清单措辞的冲突**：清单预设存在一个「识别破坏性动作」的判别器。这个仓库把该问题整体换成了能力边界问题：不判断命令语义，而是先把文件系统写权限收到白名单可写根内，再对越界与升级请求要求人工审批。

### 39. 确定性校验器的接入：测试、lint、编译、类型检查；成功静默、失败详述 [OAI][Osm][Gu]

没有把测试/lint/编译/类型检查接进 agent 回路的机制。查过三处：一、模型可见的工具目录里没有校验器工具，最接近的 `lsp` 工具的 `LspOperation` 是闭合的四个语义查询（goToDefinition / findReferences / goToImplementation / hover），新增一个会在缝、提供方与工具处编译期失败——即它连诊断（diagnostics）都不暴露，更不跑构建。二、在仓库里枚举了全部 `tools/post-execute` 监听器（非测试）：只有两个 hook 桥、fs-search 的结果渲染、spill-policy 的输出外置、repeat-tool-reminder 的重复调用提醒，没有任何「编辑后跑校验」的监听器。三、仓库里确实有 oxlint / tsc typecheck / vitest，但它们只出现在 scripts/ 与 lefthook 的开发期钩子里（pre-commit 按 `.oxlintrc.staged.json` 校验并修复、pre-push 跑 typecheck），是维护这个仓库自己用的，agent 不经手。「成功静默、失败详述」这个形态在仓库里也找不到对应实现。可行路径只有两条通用的：模型自己用 bash 工具跑命令，或者部署方配一个 PostToolUse/Stop 命令 hook（hook 的 stdout 在退出码 0 时可提升为 additionalContext，退出码 2 或 deny 则 block 并把 stderr 当 reason）——但那是用户配置，不是仓库提供的校验器接入。

**与清单措辞的冲突**：清单假定 harness 会替 agent 跑确定性校验并按成功/失败分别呈现。这个仓库把「跑什么命令」整体留给模型或部署配置，自己只提供命令执行与结果呈现的通道（超时预算、输出截断与外置、错误文本模板），不内置任何校验器语义。

### 49. 记忆写入的门控、来源与置信度标注、过期与再验证 [Gu]

仓库 packages/ 下 57 个分组没有任何记忆服务：在 packages/ 里 grep `ctx.memory`/`MemoryService`/`memoryStore` 只命中 subprocess 测试里的一个局部变量名。记忆能力全部外包给可选的外部 MCP 服务器——apps/cli/config/examples/mcp-memory/ 下 engram、mcp-reference-memory、memorix 三份 `--patch` overlay，发行组合默认不含任何 memory 行，不传 `--patch` 三者全关；docs/user/guide/mcp-memory.md 还明确写参考实现只做大小写不敏感子串匹配，没有嵌入、自动摘要、冲突消解或遗忘策略。因此写入门控、来源与置信度标注、过期与再验证都不在 harness 侧，harness 只负责 MCP 客户端行的启停、凭据类环境变量剥离与崩溃重连。找过的地方：census 全量 grep「记忆」（命中几乎全是「记忆化」memoize）、_docs.md 里 docs/user/guide/mcp-memory.md 与 docs/subsystems/ 各节、apps-cli.md 的 mcp-memory overlay 段、storage/session 两组的持久化文件，以及仓库 packages/ 的 memory 关键词扫描。

**与清单措辞的冲突**：清单这一条挂在 [Gu] 名下，假定 harness 自身存在一条记忆写入通路可供门控与标注；本仓库没有第一方记忆层，「门控／置信度／过期」在这里没有落点，唯一可调的面是 MCP 客户端行本身开不开。

### 51. 版本化状态（git）[LC][Anth]

在 packages/ 与 apps/ 里 grep `git commit|git checkout|git diff|git stash|git worktree|git rev-parse|simple-git|isomorphic-git` 零命中；census 里 git 只出现在仓库自身的开发流程——lefthook 安装器把 git 钩子装进 worktree 局部配置、双语配对的 git 合并驱动与冲突解析器、扫描 git 跟踪文件的门禁脚本。运行期 `.git` 只有两种用途：agent-instructions 把它当项目根标记（DEFAULT_PROJECT_ROOT_MARKERS）、skill-filesystem 用它探项目根，以及 glob 与文件引用把它列进 VCS 排除名单。状态版本化走的是另一套：会话 JSONL/SQLite 追加日志的 seq、投影单元的 `stateVersion`、settings 的 revision 与 `expectedRevision` 冲突拒绝、goal 的 `GOAL_CHANGE_VERSION`。模型可以用 bash 工具自己跑 git（tool-bash 的描述文本就拿 "git status" 当命令说明的例子），但那只是一条普通 shell 命令，harness 不参与也不记账。

**与清单措辞的冲突**：清单假定「版本化状态」由 git 承载；在这里 git 只是路径标记与检索排除项，harness 侧没有任何提交、检出、快照或回滚，版本化由会话日志序号与各投影／设置的 revision 承担。

### 78. 批量运行的重入：跳过已完成、结果文件的一致性维护与失败实例的处理 [mini]

仓库里没有批量实例运行器，因而也谈不上重入。找过的地方：`apps/cli/src/args.ts` 把 argv 只解析成 profile 启动、配置转储、插件管理三种调用（另有 `web` 与 `plugin` 两个子命令），没有批量入口；`python/sdk` 只有单会话客户端（client.py/api.py/models.py），没有 runner；`packages/jobs` 是会话内后台作业注册表、`packages/schedule` 是会话内定时提醒、`packages/workflow` 与 `tool-ralph` 是单次工具调用内的多轮子代理，都不跨进程调度实例集合；`packages/session/session-checkpoint-policy` 与 agents 的 `resume` 是单会话续跑，不是批量重入。最接近批处理的是 `scripts/run-gates.ts` 的闸门依赖图与 `scripts/run-coverage-partitions.ts` 的分区测试，但每次调用都重建整张图从头跑，没有任何“跳过已完成”的判定，也不写结果文件——只把通过/失败/跳过计数与失败原因打印成摘要，依赖失败的下游判 skipped、`allowFailure` 的标 NON-BLOCKING；`packages/test-support/session-snapshot` 的场景套件同样每次全跑，`scenarioSkipped` 的跳过判据只有“录制模式下跳过非录制场景”“win32 上跳过 posixOnly”“pwsh 探针为假时跳过 pwshOnly”三条，与是否已完成无关。根目录 `BENCHMARK.md` 全文三行，把批量交给使用者：照 Python SDK 指南跑 `jsonrpc-agent` 最小变体，各基准任务用独立工作目录与会话 id。

**与清单措辞的冲突**：清单假定存在“结果文件”这一形态；本仓库里与之最接近的是各快照场景目录下钉住的 expected 文件（session.jsonl、stdout.expected.jsonl、system-prompt.expected.md 等）与 refresh 模式对它们的重写，那是快照维护，不是批量运行的结果累积；失败实例的处理也只体现为闸门图里的 skipped/allowFailure 与 vitest 用例失败，没有“失败实例单独重跑”的通路。

## 五、仓库有、清单没有

共 **41** 条残差。加粗的那一行就是**建议的新行名**，写成清单那种口吻；其后一句说明为什么清单现有 78 行都没覆盖它（点名最接近的行号）。为控本文件大小，每条的机制描述没有单列——建议新行名本身已是完整一行，机制细节见其证据链接所在的普查文件。

- **服务依赖图驱动的挂载门控与级联重载：声明的 inject 未就绪即停在 PENDING 不执行插件体；依赖实现的提供者 uid 拼成 epoch，提供者换人或撤销即让所有依赖方卸载重挂**
  - 最接近的是第 77 行「组件契约的表达方式：抽象基类、协议、还是纯约定；换一个实现的代价」，但 77 问的是契约的静态写法与替换成本，这里是运行期依赖图本身：谁没就绪谁就不挂载、谁被换掉谁的下游就被级联重载，且「换人」与「撤销」走同一条 epoch 判据。（[vendor/cordis/src/fiber.ts:611-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L611-L623)）
- **服务实现的命名隔离（realm）：组合文件里一行 isolate 给一组插件开独立服务域，同名服务在域内解析到另一份实例，preset 内的实现就此遮蔽宿主的同名服务**
  - 最接近的是第 11 行「子代理的上下文隔离与结果回传」，但 11 指的是消息历史这一层的上下文隔离；这条隔离的是服务实现的解析——同一个服务名在不同子树指向不同实例，且开关是组合文件里的一行标签，与消息内容无关。（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:74-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L74-L79)）
- **插件名册本身的分层合成：每个 bundle 带一份补丁列表、profile 清单点名层序、用户补丁殿后；各层拍平后一次性作用在空名册上，补丁按 id 插入到某个组、逐键覆盖、以 disabled 停用**
  - 最接近的是第 54 行「配置覆盖的粒度与来源优先级」，但 53/54 说的是某个配置值的多来源择序；这里被分层覆盖的对象是「这次进程装哪些插件、每行给什么参数」这份名册本身，合并发生在任何插件被挂载之前，且覆盖单位是按 id 寻址的条目行而不是配置字段。（[packages/boot/app-boot/src/profile.ts:854-861](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L854-L861)）
- **作用域键的父链一条关系两个方向：注册视图沿链向下继承，事件准入沿链向上扩展；带标签的监听者只收到本作用域或其后代作用域的派发**
  - 最接近的是第 73 行「多 agent 编排与交接；共享状态与通信协议」，但 73 问的是 agent 之间怎么交接与通信；这条是同一进程内多 agent 的可见性规则本身——同一条父链决定「谁能读到谁注册的东西」和「谁能听到谁发的事件」，且两者方向相反。（[packages/core/scope/src/index.ts:32-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L32-L39)）
- **注册表的作用域分层：全局层加每作用域层，读取时由远及近合并、近层同名遮蔽远层、链上任一层的 allow/deny 掩码求交；被遮蔽或被掩掉的项在解析与派发时都读作不存在**
  - 最接近的是第 62 行「子代理的派生、回收、权限收缩」，但 62 只说派子代理时收一次权限；这里是注册表的常态结构——分层、同名遮蔽、掩码沿链求交，收缩只是往某一层追加一份掩码，且拒绝无作用域的全局收缩。（[packages/core/tools/src/index.ts:1151-1182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1151-L1182)）
- **事件派发语义的选择：emit/parallel/serial/bail/waterfall 五种；waterfall 把监听器由外向内串成链并把内建行为作为最内层 next，监听器不调用 next 即整段取代内建行为**
  - 最接近的是第 38 行「钩子：挂点清单与执行顺序」，但 38 只问有哪些挂点、按什么顺序跑；这条是一个挂点上多个监听器如何组合——bail 值的定义、以及监听器可以不调用 next 从而连内建行为一起替换掉。（[vendor/cordis/src/events.ts:234-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L234-L243)）
- **装配完成后的激活验收：逐条目比对 fiber 状态，既无 fiber 又未被禁用即判失败；FAILED 的取回其私有拒绝原因，PENDING 的报出它仍缺哪个注入服务**
  - 最接近的是第 55 行「导入期副作用：配置加载、目录创建、日志器安装、启动输出及其静音开关」，但 55 说的是启动时做了哪些副作用；这条是装配之后的验收动作——不让一个缺插件的进程带病跑起来，并把「缺哪个依赖」直接报到条目名上。（[packages/boot/app-boot/src/index.ts:725-731](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L725-L731)）
- **运行期不变量面：每个工作区包附带一份 `./invariant` 伴生插件，以自己的 npm 包名向注册表占位；由配置的正则名单决定是否真的装检查，选中的安装器在子 fiber 中运行，违规抛出带包名归属的稳定错误码**
  - 最接近的是第 39 行「确定性校验器的接入：测试、lint、编译、类型检查；成功静默、失败详述」——那说的是把外部工具接进 agent 的工作流；这里是 harness 自己进程内的一层：检查随插件一起挂载与卸载、按包名注册并占位、由 Config 的正则名单开关、失败按包归属抛出。第 70 行只讲日志与指标导出，不覆盖「运行期断言」。清单 78 行里没有「运行期自检」这一类。（[packages/runtime-diagnostics/invariants/src/index.ts:160-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L160-L168)）
- **「模型可见即已记录」的运行期反向核对：以 prepend 前插在模型调用上，把这次请求的消息与请求头参数同从会话日志折叠出的结果逐字比对，不一致即判为日志重建失步**
  - 最接近的是第 46 行「会话或轨迹记录：快照还是追加日志；格式及其版本标记…」和第 67 行「trace 记什么：模型看见的、harness 决定的、各记多少」——两条都只规定记什么、记多少、怎么写盘，没有「用日志反向重建这次模型请求并逐字比对」这一步；第 59 行的完成协议讲的是停止判定，不是记录与请求的等价性。（[packages/core/agent-loop/src/invariant.ts:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L39-L42)）
- **自检面本身的门禁：从源码 AST 与已构建产物两侧核对伴生插件的导出形状、注册名与清单接线；空安装器必须写明「本包为何无可检查」**
  - 最接近的是第 77 行「组件契约的表达方式：抽象基类、协议、还是纯约定；换一个实现的代价」——那问的是契约怎么表达；这里是契约被脚本机械判定，判定对象是「每个包都必须有的那份自检文件」的形状、注册名、清单 exports/files/peer 与 tsdown 接线，连「空实现的理由注释」都写进了判据。第 39 行的确定性校验器只涵盖测试/lint/编译/类型检查，不含这种针对仓库自身结构约定的门。（[scripts/package-invariants.ts:265-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L265-L277)）
- **构建期把源码里的服务、事件与远程方法面编译成运行期反射产物：逐条判定书写者是否符合契约，发射 JS 与 `.d.ts` 与线路 codec，并反过来核对包清单的 exports 与 files**
  - 最接近的是第 4 行「工具声明：构成、描述文本、随请求下发的方式」与第 77 行「组件契约的表达方式」——第 4 行只讲工具 schema 如何下发给模型；第 77 行只问契约用什么表达。这里是另一层：整套服务/事件/跨端方法的契约由构建期静态分析强制，并生成运行期反射产物与严格模式线路 codec，生成结果反过来约束包清单的发布面。清单没有「构建期代码生成」这一行。（[packages/typert/generator/src/tsdown-plugin.ts:108-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/generator/src/tsdown-plugin.ts#L108-L121)）
- **模型可查询的框架 API 目录是构建期投影出的已提交模块：服务、事件与类型三张表，按 key 取详情时顺带返回词边界逐轮扩张出的引用类型闭包**
  - 最接近的是第 9 行「工具与技能的按需展开：渐进披露、工具检索」——那讲的是把工具与技能按需展开；这里被展开的是 harness 自身的插件框架 API，而且这份目录不是运行时算出来的，是构建期从仓库源码与 JSDoc 投影出、随包提交的产物（含白名单、页面归属表与豁免表）。第 52 行虽提到「运行时自扩展」，但只覆盖自扩展这件事本身，不覆盖「让它可行的那份构建期生成的 API 目录」。（[packages/extensions/tool-cordis/src/api-catalog.ts:83-2857](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L83-L2857)）
- **文档完整性与单条目篇幅是生成期硬门禁：目录条目缺 JSDoc、缺 `@param`/`@returns` 或类型链接未覆盖即整次生成失败；单个条目另有行数预算**
  - 最接近的是第 8 行「工具输出的截断、外置到可查询文件、或在源头摘要」——那是运行期对工具结果做截断；这里是构建期就对模型将来会读到的每个目录条目施加篇幅上限与文档完整性要求，且不达标的处理不是截断而是整次生成失败。第 39 行的确定性校验器不含「文档质量因为文档就是模型可见正文而成为门」这一层。（[packages/typert/generator/src/cordis-catalog.ts:302-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/generator/src/cordis-catalog.ts#L302-L314)）
- **凡从源码派生的产物都以已提交形式存在：同一生成器挂成「生成」与「`--check` 逐字节比对」两个包脚本入口，产物陈旧即门禁失败并打印整改命令**
  - 最接近的是第 53 行「配置的加载、合并与落盘；提示词的版本化与发布」——那讲运行期配置与提示词的版本化发布；这里是仓库对「已提交的派生产物是否仍与源码同步」的判定，做法是同一份实现两个入口、一个写盘一个逐字节比对。第 39 行的校验器清单里也没有这种「重算并与已提交内容对比」的门。（[package.json:115-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L115-L139)）
- **录制轨迹的双重身份：已提交的会话日志既是逐行比对的期望，又被反推成模型侧的回放脚本；推导不出终止块就要求该场景另给覆盖侧车**
  - 最接近第 69 行「轨迹查看与回放工具」——那一行说的是给人看轨迹、由人重放；这里录制轨迹是喂回到 provider 位置的确定性脚本，全程无人参与，且同一份文件同时充当期望输出，没有任何查看界面介入。（[snapshots/AGENTS.md:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/snapshots/AGENTS.md#L7)）
- **请求头内容在语料里被擦成 {{system}}/{{tools}} 令牌、另存成旁挂期望文件；每个 header 类恰有一个 pin 场景当所有者，比对时从旁挂复原完整 header 序列**
  - 最接近第 1 行「系统提示的构成与来源」与第 4 行「工具声明：构成、描述文本、随请求下发的方式」——那两行讲这些文本怎么被拼出来、怎么随请求下发；这条讲的是拼出来的成品如何被从上百份语料里抽走、集中钉成一份可评审文本，以及「谁持有这份成品、能不能有第二份」的唯一性与去重判定。（[packages/test-support/session-snapshot/src/suite.ts:1398-1424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/session-snapshot/src/suite.ts#L1398-L1424)）
- **工作区副作用围栏：未声明 workspace.final 的场景断言终态必须等于初态；声明了才与 workspace.expected/ 全量比对，且录制与刷新都不重写这份期望**
  - 最接近第 39 行「确定性校验器的接入：测试、lint、编译、类型检查；成功静默、失败详述」——那一行讲把校验器接进循环、结果给模型看；这条是在循环之外对 agent 一次运行留下的文件系统副作用做全量围栏，默认口径是「不得有副作用」，并刻意让这份期望不能被重录悄悄吸收。（[packages/test-support/session-snapshot/src/suite.ts:1494-1500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/session-snapshot/src/suite.ts#L1494-L1500)）
- **刷新模式的易变字段回填：把旧语料的消息 UUID、时间、打包成员时间与溢出路径带进新产出，并复用归一化后等价的字符串；任一处记录类型错位即整体关闭复用**
  - 最接近第 78 行「批量运行的重入：跳过已完成、结果文件的一致性维护与失败实例的处理」——那一行讲批量评测怎么重入与维护结果文件；这条讲的是重录同一份语料时如何让 diff 只剩真实变化，判据是新旧记录的逐条对齐与双向映射一致性，而不是跳过或覆盖。（[packages/test-support/session-snapshot/src/suite.ts:1065-1117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/session-snapshot/src/suite.ts#L1065-L1117)）
- **可脚本化的假模型服务器：按序列逐请求演出二十余种线路行为——连接重置、流中途断开、SSE 畸形帧、只发头就挂住、429/401/上下文超限——带加权随机与可复现种子**
  - 最接近第 23 行「重试、退避、可中止的错误类型（含内容过滤错误）」——那一行讲遇到错误之后怎么退避、哪些可中止；这条是把这些错误按脚本主动制造出来的一台线路级故障注入服务器，故障发生在 HTTP/SSE 这一层（半截流、错内容类型、静默挂起），并把每次结局记成语料。（[packages/test-support/llm-mock-server/src/index.ts:16-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L16-L41)）
- **受限宿主里没有进程：bash -c 被交给自写的 shell 解释器（管道、&&/||、重定向、$( )、glob、算术展开），命令本体来自一张闭合命令表，表外的名字一律 command not found 加 127**
  - 最接近第 34 行「执行环境：本地、容器、远程沙箱；每个动作的进程模型」——那一行讲动作跑在哪个进程、容器或沙箱里；这条讲的是根本没有 shell 也没有进程可用时，命令行语义由 harness 自己实现，智能体能跑哪些命令由一张手工登记的程序表界定，表外即不存在。（[packages/experimental/webworker-runtime/src/shell/programs/index.ts:14-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-runtime/src/shell/programs/index.ts#L14-L28)）
- **依赖替身的分级：能算的照真值答，不能做的造成结构完整、一调即抛并点名模块与成员，个别故意留成不完整形状让上游的能力探测得出否定结论**
  - 最接近第 27 行「提供商原生能力的接入（原生搜索、原生执行、原生压缩）与本地回退」——那一行讲某能力有原生实现时怎么接、没有时怎么退；这条讲的是整层宿主能力缺失时，依赖表面如何被逐成员分级顶替，尤其包括「刻意让调用方探测不到某能力」这种主动做废的手法。（[packages/experimental/webworker-runtime/src/node/builtin_modules/implemented/zlib.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-runtime/src/node/builtin_modules/implemented/zlib.ts#L49-L51)）
- **类型驱动的远端方法面：`@Remote`/`@RemoteScope` 标注实例方法，描述符声明 namespace/method、逐参数编解码器与接收者上下文；注册表按端点与调用 id 查重后发布，无严格描述符时读方法源码文本切参数名兜底推导**
  - 清单最接近的是 77「组件契约的表达方式：抽象基类、协议、还是纯约定；换一个实现的代价」，但那说的是同进程内组件之间怎么声明契约、换实现要付什么代价；这里是把 TypeScript 方法签名本身铸成跨进程调用契约（线路名字法、字段级编解码器、lookup/context 两种接收者解析、端点重复与歧义的判定），78 行里没有任何一行讲 harness 自带的类型化 RPC 面。（[packages/typert/registry/src/service.ts:655-663](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L655-L663)）
- **界面文案的本地化运行时：语言目录与回退链（拒绝环、必须收敛到英语）、按（命名空间, 语言）注册的字典、`{name}` 占位插值、逐链未命中即把键名本身当文案显示**
  - 清单最接近的是 71「界面层与前端协议：CLI、TUI、Web、编辑器协议（ACP）、UI 事件流、语音」，它只列界面有哪些形态，完全不涉及同一界面的文案有几套语言、按什么链回退、缺键怎么办、参数怎么插；43「观察结果的渲染」讲的是送进模型上下文的观察模板，不是人读文案的多语言。（[packages/client/locale/src/client/index.ts:447-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L447-L451)）
- **界面按具名槽位由插件竞争填充：single/keyed/chain/list 四类槽位各有分派与裁决；每个条目一层错误边界，遮蔽类崩溃即退位换下一位幸存者、chain 类只上报不退位**
  - 清单最接近的是 72「插件或扩展机制：MCP、技能、能力单元、插件内核」，那讲的是工具、技能一类能力单元怎么被扩展进来；这里是界面本身作为一张可竞争注册的槽位图——四种槽位种类、同格多注册者的遮蔽裁决、崩溃即退位的降级语义，71 也只说到界面层有哪几种形态。（[packages/client/ui-renderer/src/client/scoped-slots.tsx:748-750](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L748-L750)）
- **一条 WebSocket 上复用多条可独立取消的逻辑流：随机 streamId 加 open/item/end/error/cancel 帧，消费者提前退出即补发 cancel；连接丢失时失败全部在途流并按 500ms 起翻倍、上限 10s 加抖动重连**
  - 清单最接近的是 25「流式输出与事件流的处理」，那说的是模型侧输出流与事件流怎么被消费；这里是 harness 自建的宿主↔浏览器多路复用载体本身——帧种类与精确键集、按 streamId 的分发与取消、关闭码的选择、退避加抖动的重连。71 提到「UI 事件流」，但不涉及承载它的这条通道协议。（[packages/api/gateway/src/client/stream-client.ts:78-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/client/stream-client.ts#L78-L106)）
- **宿主事件按白名单转发到前端，waterfall 类事件把决策权交出去：一个待答事件向所有已连接客户端扇出，先给出 result 的胜出、任一 rejected 即取消、全体回 next 才落回宿主自己的处理链**
  - 清单最接近的是 32「权限模式、白名单、确认关卡、人在回路；延迟工具」，它讲有没有这道关卡、谁来批；这里是那道关卡的跨进程裁决协议——宿主的 waterfall 决策链延伸到多个浏览器客户端，扇出后按「先到者胜/全体弃权才落回」结算。73「多 agent 编排与交接；共享状态与通信协议」说的是 agent 之间，不是宿主与前端之间。（[packages/api/gateway/src/index.ts:531-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/index.ts#L531-L550)）
- **流式富文本的稳定前缀冻结：Markdown 增量解析每次只把尾部切片交给语法解析、末尾保留 2 块不冻结，冻结块的 React 元素按绝对起始偏移缓存复用；新文本不以旧文本为前缀即整代作废重来**
  - 清单最接近的是 25「流式输出与事件流的处理」，那是接收侧对 chunk 的累积与处理；这里是显示侧为了让长回答边流边渲不整棵重建而做的前缀冻结、按偏移 key 的元素复用与代次作废。43「观察结果的渲染」讲的是送给模型的观察模板与占位，不是人读富文本的增量渲染。（[packages/client/ui-primitives/src/markdown/incremental.ts:117-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L117-L121)）
- **命令输出按终端语义重放而非当纯文本贴出：列缓冲重放 `\r`、退格与行内擦除，制表符推进到下一个 8 列停，宽字符占两列并配 spacer 尾格，逐格盖当刻 SGR 状态后折成带样式 run**
  - 清单最接近的是 43「观察结果的渲染：模板、占位、错误信息的形态」，那说的是工具结果送进模型上下文时的模板与占位形态；这条是同一份输出字节流给人看时按终端语义（光标移动、列宽、宽字符配对、颜色与属性状态机）重建出的呈现，78 行里没有任何一行提到终端控制序列的解析与列宽计算。（[packages/client/ui-primitives/src/ansi.ts:238-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L238-L249)）
- **事件日志的投影单元：按 key 注册的 init/apply/wire 折叠契约；每单元一个 stateVersion 与水位；apply 返回同一引用即零下游工作**
  - 最接近的是第 46 行（会话或轨迹记录：快照还是追加日志…）与第 69 行（轨迹查看与回放工具）——46 只管这条日志本身怎么记、69 只管事后拿什么工具去看，两行都没有「进程内按 key 注册的折叠单元把已提交事件流实时折成宿主状态与线上视图，并以状态引用是否变化作为下游通知的门」这一层派生结构。（[packages/session/session-projection/src/index.ts:630-636](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L630-L636)）
- **派生视图的检查点缓存：turn/end 与会话创建为必写点、其余按脏计数与定时器双触发；检查点只当折叠的种子，解析失败即退回空检查点重折**
  - 最接近的是第 47 行（检查点、续跑、分叉；持久执行引擎的集成）——47 的检查点是为了让执行接着跑、是恢复所必需的，而这里的检查点纯粹是派生视图的加速缓存：版本不符、身份不符或解析失败都只是退回空检查点重折一遍全日志，正确性从不依赖它，差别在于一个是恢复点、一个是随时可丢的缓存。（[packages/session/session-projection-cache/src/index.ts:229-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L229-L239)）
- **追加日志上的表面层：后来的事件可遮蔽更早的表面区间；替换必须在 sourceEventSeqs 里点名每个被遮蔽的 seq；replaceGeneration 自增使派生消息缓存整段重建**
  - 最接近的是第 6 行（会话历史的组装：全量重发、裁剪、摘要；调用前的历史处理钩子）——第 6 行讲的是把历史交给模型之前怎么处理，而这里是日志内部先立起来的一层：哪些事件在表面上、后来的事件能遮蔽哪一段、遮蔽必须逐条点名来源、遮蔽发生时靠一个代号把派生历史整段作废，模型历史只是这层表面的投影结果。（[packages/core/session/src/surface.ts:239-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L239-L242)）
- **附件的内容寻址对象库：归一化字节的 sha256 既作 id 又作路径；硬链接发布、EEXIST 即读回比对摘要当去重命中；发布后 chmod 0400**
  - 最接近的是第 16 行（多模态输入的处理）——它只说多模态输入要被处理，没有说这些字节的身份怎么铸、同一张图反复提交怎么办；这里是内容摘要即 id、id 即路径、重复写入在 EEXIST 分支退化成一次摘要比对而不是覆盖，是一套内容寻址加天然去重的对象库，而不是输入处理管线。（[packages/attachment/attachment-local/src/store.ts:217-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L217-L224)）
- **日志记录本身的物理编码：连续同类流式增量压成一行并把时间戳存成相邻差值；data 列用随包发布的 zstd 字典压且只在更短时才写压缩字节；溯源序号同时试差值与游程两种编码取短**
  - 最接近的是第 46 行（会话或轨迹记录：快照还是追加日志；格式及其版本标记与写入者版本；写盘时机；原子性）——它管的是记什么、何时写、原不原子、格式版本怎么标，唯独没有「一条记录内部怎么编码」：游程打包、时间差数组、带字典的列级压缩、双编码取短这一整套体积换解码成本的设计不在它的任何一个分句里。（[packages/session/session-persistence-sqlite/src/compression.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L37-L42)）
- **冷会话读取的共享预备池：同 id 的在途冷读合并成一次；已就绪的未发布会话按带钉住的 LRU 淘汰；取用前用存储修订号核对是否过期**
  - 最接近的是第 47 行（检查点、续跑、分叉）与第 65 行（崩溃恢复）——那两行问的是一个会话能不能被接着跑起来，而这里是读路径上的一层缓存结构：把同 id 的在途冷读合并、把已解析好的未发布会话按容量与钉住状态淘汰、复用前先用存储修订号判定失效，属于命中即返回与淘汰策略，而不是恢复语义。（[packages/session/session-persistence/src/preparations.ts:338-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence/src/preparations.ts#L338-L351)）
- **本地 Web 载体的浏览器会话认证与 /api 信任栅栏：进程启动令牌换签名 Cookie；Host 回环与 trustedHosts、sec-fetch-site、Origin 三重围栏**
  - 最接近的是第 71 行「界面层与前端协议：CLI、TUI、Web、编辑器协议（ACP）、UI 事件流、语音」，它只问界面形态与协议种类；第 75 行「安全治理与审计面」限定在记忆写入、路由变更、工具权限。两行都不涉及 harness 自带的 HTTP 服务如何判定「这个浏览器是不是本次启动的那个人」以及如何抵挡 DNS rebinding 与跨站请求。（[packages/client/connection/src/browser-auth.ts:240-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/connection/src/browser-auth.ts#L240-L266)）
- **模型发起的一次性沙箱提权：sandbox_permissions 加 justification 作为工具参数；只在组合真有可升级后端时才进 schema；拒绝结果里附同轮升级提示；审批被禁用时明令禁止填写**
  - 最接近的是第 32 行「权限模式、白名单、确认关卡、人在回路」，那讲的是 harness 侧对调用设关卡；这里是反方向的一层——把提权做成模型可填的工具参数，由模型带一句理由主动申请，并且这两个字段的可见性随组合里有没有可升级后端动态增删、随审批策略在提示词里被显式关闭。第 37 行「破坏性动作的识别与拦截」只到拦截为止，没有拦截之后的申诉通道。（[packages/shell/tool-bash/src/index.ts:256-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L256-L269)）
- **一步内多工具调用的屏障分组调度：每组开头按首个待办的执行模式重新分类；组内跑 maxParallelToolCalls 的有界滚动池边结算边补位；结果只沿模型顺序的连续槽位提交**
  - 最接近的是第 36 行，它把这件事写成「并行或串行执行」的二选一；仓库里两者在同一步内共存，且并行度是每组重读的运行时配置、分类是每组重查的注册表判定（注册表中途改动能凭空造出一道屏障），结算顺序与提交顺序被刻意解耦。第 44 行「程序化工具调用」讲的是脚本批量调工具，不是循环自己的调度器。（[packages/core/agent-loop/src/tool-calls.ts:84-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L84-L93)）
- **按请求身份的在途单飞：同键调用复用一次共享工作；各等待方独立取消，最后一个等待方取消才中止共享控制器；结算后自删在途表项**
  - 最接近的是第 36 行末尾的「幂等」（讲重复执行是否安全）与第 41 行「预算与速率限制」（讲总量额度）。两者都不覆盖「同一请求身份的重叠调用合并成一次工作、等待方计数决定共享工作何时被取消、结算后按身份判等清表」这套在途去重语义——它既不是幂等性也不是限额，而是取消权的归属问题。（[packages/attachment/attachment-local/src/index.ts:134-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L134-L139)）
- **后台作业的每所有者并发席位准入：running 与 stopping 占位、终态释放；超额在调用生产者之前拒绝且不留 id；list/get/kill 走所有者会话围栏**
  - 最接近的是第 41 行「预算与速率限制」，那是按 token 或花费计的额度；这里是按「所有者会话」计的并发席位，占位单位是作业状态（running/stopping 占、终态放），并且拒绝点被刻意放在生产者启动之前以保证无副作用。第 62 行「子代理的派生、回收、权限收缩」管的是子代理，不是后台作业的席位与所有权围栏。（[packages/jobs/jobs-local/src/index.ts:143-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L143-L148)）
- **信号投递的 PID 复用围栏：pid 加启动时刻构成进程身份，每次投信号前先按身份复核存活；扫描失败时沿用已捕获的身份集**
  - 最接近的是第 36 行「超时后的回收范围——直接子进程还是整个进程组、残留容器」，它只问回收打到哪一层；这条讲的是回收的正确性前提——回收目标的身份如何被钉住与复核，使得 pid 被系统复用后不会误杀无关进程，以及进程表扫描失败时如何退回已捕获的身份集继续收尾。清单里没有任何一行谈进程身份。（[packages/subprocess/subprocess-local/src/process-inspector.ts:360-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess-local/src/process-inspector.ts#L360-L362)）
- **请求装配期的图片双预算卸载：张数与字节两项超额分别按量子向上取整成移除目标，沿请求顺序最旧优先替换成带找回路径的占位文本**
  - 最接近的是第 16 行「多模态输入的处理」，那讲的是输入侧怎么接收与处理图片；这条是请求装配侧的预算驱逐——已经在历史里的图片按路由容量被逐级降级成文本，且降级量是量子化的、被驱逐者带着可找回的引用。第 8 行「工具输出的截断、外置到可查询文件」只覆盖工具输出，第 7 行「压缩」是对话历史层面的摘要与丢弃，都不是逐请求、按模态的字节预算投影。（[packages/llm/llm/src/content.ts:241-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L241-L263)）

## 六、作者说他们在意什么

从 `README.md`、`AGENTS.md`、`docs/` 各篇、`website/`、各包 README、`.agents/notes/` 的 Agent Note，以及 14226 个提交的提交信息里摘出的**作者自述**设计取舍。每条都配原文出处。

**issue 取不到。** 本会话对 `deepseek-ai/deepseek-harness` 只有匿名 git 读权限，GitHub API 工具不覆盖未挂载的仓库，因此 issue 与 PR 讨论无法读取；上面的来源里不含 issue。

共摘出 **169** 条，此处列前 40 条（受本文件 120 KB 上限所限）。这 40 条的全文另存一份在 [`census-findings-extra.md`](census-findings-extra.md) 第二节，其余 129 条的工作文件已丢失、保持现有条数不重新生成。

- 作者把项目定位在 developer preview 并明说在快速迭代，同时用大写宣告"一定会有破坏兼容的改动"——要的是迭代速度，明确不承诺兼容稳定。（[README.md:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/README.md#L13)）
- 发布前的总纲是"foundation over blast radius"：宁可改动面大，也要正确的地基——可以随意重命名或重新分包并更新所有引用，明确不做兼容垫片；后端直接拒绝旧的磁盘格式，`SESSION_FORMAT_VERSION` 停在 `0` 且不给兼容承诺。（[AGENTS.md:5-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L5-L7)）
- 应用启动入口只留 `dsh` profile 一条路：package bins、demo 和公开 SDK 的 argv 逃逸一律禁止——放弃入口的灵活性，只保留一种受支持的启动方式。（[AGENTS.md:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L9)）
- 沙箱挡住 gh／pnpm／构建／测试／生成器命令时，允许原样重试并做"最窄的"主机升权；但要求给出沙箱证据，并划死红线：绝不借此绕过测试失败或产品沙箱。（[AGENTS.md:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L88)）
- 本地只跑与改动面对应的检查，明确禁止默认跑全量套件、也禁止为提交或推送重复已通过的检查；穷尽覆盖和平台矩阵整体交给 CI，本地全量演练只在显式要求、诊断 CI 或不可再分的全仓改动时进行。（[AGENTS.md:94-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L94-L95)）
- 任何贡献都必须经 `ctx.effect()`／`ctx.on()` 注册，registry 的 `register()` 返回 disposer——把"可卸载"做成硬性前提。（[AGENTS.md:106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L106)）
- 运行时不变量只断言自己拥有的关系：检查权威事件流或可变数据，不检查服务／方法是否存在、插件元数据或效果、固定的纯示例；没有可信关系时，宁可留一个有解释的空断言。（[AGENTS.md:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L107)）
- 会话事件词表 fail-closed：不认识某个事件类型的构建直接拒绝整份日志，只有结构性的格式变化才提升 `SESSION_FORMAT_VERSION`。要的是词表严格，放弃旧构建读新日志的容错。（[AGENTS.md:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L108)）
- "模型可见 ⟺ 已记录"是硬约束：凡是进入模型请求的东西都必须能从会话日志重建，代价是新增任何模型可见输入都必须同时新增一个 session event。（[AGENTS.md:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L111)）
- 新行为一律挂到已文档化的扩展点上，而不是改主循环；确实要改 `agent-loop`，就必须同时更新 docs/architecture.md。（[AGENTS.md:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L112)）
- 能力缝必须 Service Definition／Service Provider／Consumer 三个角色齐全，"完整，绝不只有一个角色"；只有当角色确实各自独立演进时才拆开。（[AGENTS.md:113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L113)）
- 倾向用有维护的外部依赖而不是自己手写，但设了门槛：只有当它确实能删掉自有代码和测试时才算数。（[AGENTS.md:114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L114)）
- 包边界上显式优先于隐式：默认值必须是所属实现里一个显式的 `resolve(request): Spec` 步骤，绝不是藏在 `run()` 里的 `?? default`。（[AGENTS.md:115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L115)）
- 插件里不许有写死的可调项：随部署变化的取值必须做成能从 cordis.yml 改的、经校验的 `Config` 字段，`DEFAULT_*` 常量或测试钩子不算可配置；反过来明确划线：协议常量、外部规范和安全不变量保持固定。（[AGENTS.md:116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L116)）
- 配置错误要大声失败：能自检的在加载时失败，否则在最早能判定的点失败；绝不静默跳过缺失的引用。（[AGENTS.md:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L117)）
- 同进程的类型化边界上信任 TypeScript：不为静态接口已保证的值加运行时校验、兜底行为或恶意输入测试；校验集中在 parser/config、队列、模型与工具 JSON、持久化文件、worker、进程和线协议这些边界上。（[AGENTS.md:119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L119)）
- 源码面与产物面严格分离、绝不混用：静态门禁和测试通过 tsconfig `paths` 解析到 `src`，在干净树上就能通过；要消费构建出的 `lib/` 的门禁必须显式声明这个依赖。（[AGENTS.md:120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L120)）
- 注释保持本地：不复述代码，不解释远处的行为（除非本地确有需要），也不顺手扩写无关注释。（[AGENTS.md:123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L123)）
- 测试被定位成"描述行为，而不是证明正确"：行为过时就连同它的测试一起改，只要求在 PR 里解释原因。（[AGENTS.md:125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L125)）
- 非琐碎改动必须在同一个 PR 里附 Agent Note，只有机械性／局部编辑豁免；已归档的 note 冻结，既不许编辑也不许当作现行依据。（[AGENTS.md:126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L126)）
- 客户端 UI 文案归 locale 所有：产品文本必须走类型化词典和 `t` 或本地化的 primitive props，`verify-client-ui-i18n` 直接拒绝硬编码文案。（[AGENTS.md:127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L127)）
- 快照 fixture 在 macOS/Linux 回放；出现差异时改 fixture，不改归一化器。（[AGENTS.md:128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L128)）
- 两个 SDK 都是 agent loop 的投影：agent-loop、会话生命周期和 `SessionEventMap` 的改动必须在同一个 PR 里更新 TypeScript 和 Python SDK 的期望输出，而作者明说 `pnpm run test` 两边都覆盖不到。（[AGENTS.md:131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L131)）
- 全仓在 `strict: true` + `noImplicitAny` 下编译；残留的每一个 `any` 都必须解释为什么无法收窄。（[AGENTS.md:143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L143)）
- 文档和注释只写完整的契约与上下文，不写推理过程；用直白具体的词，明令禁止比喻，连 `contract`／`boundary`／`shape` 这类词也要求先问有没有更精确的名字。（[AGENTS.md:145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L145)）
- 规则出现例外时用窄的、有理由的豁免，而不是全局关掉一条规则。（[AGENTS.md:145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L145)）
- 指令文档能压缩就压缩，但前提是清晰度还在；内容确实需要更多空间时，提高 `verify-doc-budgets` 的上限而不是硬压。（[AGENTS.md:151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L151)）
- `vendor/` 里的包是钉住的源码副本（manifest 在 vendor/README.md 记上游 SHA），并允许有记录的本地修改；代价是每次按同步流程更新都要重放或退役这些本地修改，并重跑 `pnpm run test && pnpm run build`。（[AGENTS.md:155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L155)）
- 一边明说"我们深信开源社区的力量"，一边因为项目还早、在活跃开发中而明确不接受外部 PR，只把参与方式开放在报 issue、做插件、写文章等代码之外的路径上。（[CONTRIBUTING.md:7-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/CONTRIBUTING.md#L7-L9)）
- 团队很小，坦承无法回复每一条帖子，于是把点赞当成资源分配时的参考信号。（[CONTRIBUTING.md:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/CONTRIBUTING.md#L12)）
- 不给官方仓库里的包特权地位：明说它们并不比社区创建的包更重要，本仓库是"一个想法、一个官方示范、一个灵感来源"，而不是强制规范。（[CONTRIBUTING.md:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/CONTRIBUTING.md#L19)）
- 自我定位为实验性的开发者预览软件：没有做过安全审计，明说不得被当作安全或生产可用。（[SAFETY.md:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/SAFETY.md#L7)）
- 主动降低对自家沙箱的承诺：沙箱、审批提示和权限控制只能降低风险，不保证隔离也不防止损害，即使限制被正确执行也保护不了项目本就被允许访问的资源；因此明说不要把它当作不可信负载的唯一安全控制。（[SAFETY.md:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/SAFETY.md#L13-L15)）
- 为维护生态健康、避免用户混淆，建议社区项目用缩写 "DSH" 命名，并请避免在项目名里直接使用注册商标 "DeepSeek Harness"；描述与本项目的关系则可以照实写。（[BRAND_GUIDELINES.md:8-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/BRAND_GUIDELINES.md#L8-L9)）
- 第三方声明只列工作区声明的**直接**依赖（外加显式披露的官方 Claude Code 平台载荷闭包），完整的传递闭包交给 `pnpm-lock.yaml` 和 `uv.lock`；这份文件由脚本生成、pre-commit 重生成、测试断言提交的字节一致。（[THIRD_PARTY_NOTICES.md:8-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/THIRD_PARTY_NOTICES.md#L8-L10)）
- Cordis 框架及其基础库选择源码 vendoring 进仓库并以 `@deepseek-ai` scope 重新发布，而不是从 npm 消费；上游提交与本地修改另记在 vendor/README.md。（[THIRD_PARTY_NOTICES.md:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/THIRD_PARTY_NOTICES.md#L14)）
- 对官方 Claude Code SDK 及其平台载荷的授权刻意做成按身份限定：明确声明这不等于把它们的条款归类为宽松许可，也不覆盖任何无关的运行时包，版本、声明许可与载荷集合的变化仍要走常规的依赖、lockfile、兼容性、条款与声明审查。（[THIRD_PARTY_NOTICES.md:119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/THIRD_PARTY_NOTICES.md#L119)）
- 开发依赖这一层记录的是"谁声明了这个包"，而不是"构建最终打进了什么"；传递引入以 `pnpm-lock.yaml` 为准。作者主动说明这一层的语义边界，避免被误读成打包清单。（[THIRD_PARTY_NOTICES.md:137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/THIRD_PARTY_NOTICES.md#L137)）
- 要的是「一切皆插件、每个部件都能从配置替换」；放弃的是一个可以直接改的产品内核——连模型适配器、工具注册表、会话日志、agent 循环本身都被降格成插件。（[docs/architecture.md:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/docs/architecture.md#L11)）
- 明确拒绝「打补丁改核心」这条扩展路径：扩展只能是在旁边挂插件，代价是所有注册都必须写成可回卷的 effect。（[docs/architecture.md:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/docs/architecture.md#L13)）

## 七、这个仓库的脾气

7 条，其中 **2 条不在 `checklist.md` 的任何一行上**。只陈述做法，不评价好坏。

### 请求信封本身是一条会话事件，请求可从日志重建

每次模型请求派发前，先在本步里追加一条 `request/header` 事件，载荷 `EpochHeader` 含 call config、adapter 默认值标记、渲染后的 system prompt、组装好的 tool schemas 四个字段，JSDoc 写明它是 log-only、由最新快照重建请求头；紧邻的 `request/context` 只在路由或容量变化时记，并声明不参与请求重建与 header 相等性比较。仓库把这条写成硬规矩（AGENTS.md:111）：凡是到达模型请求的东西都必须能从会话日志重建，新增一项模型可见输入就要新增一个会话事件。

为什么独特：system prompt 与工具表在多数 harness 里是运行时现拼、不入日志，这里它们与消息一样是日志成员，存档字节能精确重建当时那个请求。

对照清单：清单第 46 行。证据：[packages/core/session/src/types.ts:287-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/types.ts#L287-L301)

### 压缩与裁剪只在 surface 上遮蔽，日志永远不删

裁掉一段工具输出时不做就地改写：先追加一条 `compaction/prune` 事件，记下被遮节点的 `shadowedRange` / `shadowedSeqs` 与 token 估价（注释称其为 shadow-price protocol，计量事件与替换件同步相邻追加）；随后追加一条新的 `tool/result`，带 `surfaceOp: { op: 'replace', start, end }` 与 `sourceEventSeqs`，把原节点从模型可见面上遮掉。原始全文事件仍留在 append-only 日志里，README 说明一次 replace 只是让复用从首个被遮消息处失效，底层事件日志保持追加。

为什么独特：通常压缩是把历史数组里的元素替换或删除、旧内容随即消失，这里模型看到的「面」与日志是两层，压缩是一次可回放的定位操作而非破坏性写。

对照清单：清单第 7 行。证据：[packages/compaction/compaction-tool-result-pruner/src/index.ts:159-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L159-L173)

### 把会话日志增量上传给模型提供方，水位线自己也是一条会话事件

一个默认关闭的可选插件在官方 DeepSeek 请求上注册 `dsh_session_log` 扩展字段：用 `acceptedThrough()` 折出该会话已被接受的最大水位 `afterSeq`，把 `snapshot.slice(afterSeq + 1)` 这段连续后缀连同 `session.header` 一起随请求发出；adapter 在 HTTP 非 2xx 抛错之后、读 body 与消费 SSE 之前调 `extensions.accept()`，回调即 `session.append('session-log-deepseek/delivery-accepted', …)`，这条确认记录本身进日志，并作为新后缀的一部分参与下一次上传。README 声明方向是 at-least-once（不确定就重复、绝不跳号），且整套内容不进 messages、system prompt 或 tool schemas，模型零输入 token。

为什么独特：这是把一套带水位线与重传的日志复制协议塞进 LLM 请求体，且它对模型完全不可见。

对照清单：**清单任何一行都没有**。证据：[packages/session/session-log-deepseek/src/index.ts:69-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L69-L99)

### 提权是一个工具参数，不是一次弹窗

被沙箱拒绝后，模型可以把同一条命令原样重发，额外带上 `sandbox_permissions`（更宽的模式）与 `justification`（给用户看的理由）——它们是 bash 与 fs 两族工具 schema 里真实存在的字段。`approveEscalation` 在任何东西执行之前按固定顺序判定：先查请求是否「严格更宽」于本次调用的 effective mode（注释写明这是执行期检查，故意不写进 schema 的 enum），再看有无 composed 的审批服务，再看有无可路由的 agent，最后把 `allowed-once` / `rejected` / `cancelled` / `unavailable` 各映射成不同的逐字错误文本；授予的模式只盖在提出请求的这一次调用上。

为什么独特：提权在这里是模型在同一回合内用工具参数发起、由执行期判定的一张闭合模式阶梯，不合规的请求根本不会惊动人类。

对照清单：清单第 32 行。证据：[packages/sandbox/sandbox/src/escalation.ts:143-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L143-L189)

### 沙箱的最后一级是自己写的 298 行 C 启动器

`native/landlock-run` 是一个 self-restrict-then-exec 的 Landlock 启动器：把 Landlock ruleset 装在自己身上再 `exec` 目标命令，ruleset 跨 `execve` 继承，因此被包住的命令及其全部子进程受限而调用方不受限。整份 main.c 共 298 行纯 C11，直接打 Landlock 原始 UAPI（结构体在文件里自定义、不引 `<linux/landlock.h>`），静态链接 musl，按平台预编译发 npm 包；`--ro` / `--rw` 之外一律拒绝，内核没有 Landlock 或被禁用时 fail closed，绝不 unconfined 地 exec，二进制与入口包一律不读环境变量。

为什么独特：同类 harness 在 Linux 上一般是 shell 出去调 bwrap 或 Docker，这里为 bwrap 不可用的场景（没装、user namespace 被关、LSM 禁 mount）自己写了一层内核 LSM 启动器并随包分发。

对照清单：清单第 34 行。证据：[native/landlock-run/packages/entry/src/main.c:1-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L1-L36)

### guard 只能否决，不能放行

`ctx.tools.guard()` 注册的是同步 `ToolGuard`，签名 `(execution: Readonly<ToolExecution>) => string | undefined`：返回字符串即拒绝，返回 `undefined` 即维持原状；它跑在可扩展的 `tools/pre-execute` 瀑布之后、工具体之前。注释逐字写着「Because guards have no allow result, listener ordering cannot turn a denial back into permission」，注册方法上再补一句没有任何 guard 能强行放行另一个 guard 拒掉的调用。

为什么独特：常见 harness 的 hook 或权限回调既能 deny 也能 allow、于是谁排在后面谁说了算，这里把「放行」这个返回值从类型上删掉，拒绝在整条链上单调不可逆。

对照清单：清单第 33 行。证据：[packages/core/tools/src/index.ts:704-712](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L704-L712)

### 每个包的 README 必须写「模型看到了什么」

`verify-package-readme-model-experience.ts` 要求包 README 带逐字的 `## Model Experience` 段，其下每个 `### <条目>` 必须恰好三个有序四级标题 `#### What the model sees` / `#### Token effect` / `#### KV Cache effect`，连空行位置都校验。整段不写的包必须出现在源码里的 `NO_MODEL_EXPERIENCE_SECTION` 白名单并附一句理由（注释说这句理由留在此处是可复核的审计证据，好让「缺失」不被误认为「忘写」）；只写一句话的包进 `SENTENCE_MODEL_EXPERIENCE`，句子必须以 `None, as ` 或 `Indirectly, through ` 开头。门禁还反查白名单条目是否指向真实包、理由是否为空、有没有同时出现在两张表里。

为什么独特：把「这段代码对模型上下文、token 与 KV cache 的影响」当成包级文档的必填字段来卡，并把豁免理由本身也纳入受检范围。

对照清单：**清单任何一行都没有**。证据：[scripts/verify-package-readme-model-experience.ts:13-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/verify-package-readme-model-experience.ts#L13-L49)

## 八、卡外发现

- **三个 snapshot 期望文件是符号链接，blob 与工作区不同一。** `snapshots/acp/escalation-approved/system-prompt.expected.md` 等三条路径在钉住提交上是 mode `120000`，blob 内容只有链接目标那一行；普查 agent 读的是磁盘上解析后的目标文件（30 行），照着写了行号，`check_anchors` 读 blob（1 行）于是报了 40 条 `line-out-of-range`。这正是锚点校验该抓的东西——它证明的是「blob 上这个位置存在」，而不是「工作区上这个位置存在」。已改成如实记「这是符号链接、指向谁」并锚在第 1 行（[snapshots/acp/escalation-approved/system-prompt.expected.md:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/snapshots/acp/escalation-approved/system-prompt.expected.md#L1)）。
- **`make coverage` 排在 `make selftest` 前面，导致覆盖一红、自测在 CI 里根本没跑过。** 普查未收口那段时间 CI 一直红在覆盖上，而 selftest 是它后面一步，从未执行。本地补跑确认 61 条断言全过，但这个顺序本身是个可观测性缺口：**排在失败步骤之后的检查，其绿与红都无从得知**。本卡没有改这个顺序（不在卡面范围），记在这里。
- **在反引号里写 `host:port` 会被锚点校验当成 `path:line`。** 普查里一条讲监听地址的证据行写了 127.0.0.1 加冒号加端口，被 `check_anchors` 判成「127.0.0.1 不是这个仓库里的文件」。校验器的文档写明逃生口是去掉反引号，本卡照做。这是短形式锚点语法与网络地址写法的一处天然重叠，值得后续笔记留意。
- **`.agents/` 是按「不属于普查的六类」出局的，不是被排除规则排掉的。** 覆盖脚本的报告把两者分开计数，但读者容易把 2492 个「不在 roots 下」的文件误读成「被当成测试或构建产物」。`.agents/notes/` 按其自身 README 是决策记录（Agent Note），既不是源码也不是随包文档；它没进普查，却是第六节「作者说他们在意什么」最主要的来源之一。
- **本仓库两次普查的密度差约 2.6 倍。** mini-swe-agent 是 75 个文件 / 1449 条证据行 ≈ 19.3 行每文件；deepseek-harness 是 3812 个文件 / 28241 条证据行 ≈ 7.4 行每文件。差距主要来自 snapshot 语料、包 README 与清单文件这类稀疏文件在后者里占比高得多（仅 `_snapshots` 一篮就是 615 个文件）。拿两个仓库的「证据行数」直接比密度会误导，要比就得先按文件种类分层。
- **归族这一步暴露了清单的取景框。** 26 个族里有 4 个（无运行期机制的空条目、包清单与构建配置字段、不变量伴生插件的登记与自检、构建期产物的生成与改写）对不到清单任何一行，共同点是它们属于「仓库自身的工程与自检面」；而清单是站在 agent harness 运行期视角写的。这不是清单的缺陷，是它的视角边界——但做残差时要意识到，「仓库有、清单没有」里有一部分并非清单遗漏，而是清单本就不打算收。
- **清单的行号有两套，彼此不一致。** `matrix.md` 表头定义的编号是权威的一套：第 1–68 行是第二版原有的行，第三版新增的 10 行拿 69–78 且各自排在所属组末尾，所以「元模型组合器」是第 71 行。而本文件第四、五节引用清单时用的是**清单文件里的行序**，同一条在那里是「28」。两套号在第三版新增的那 10 行上系统性错位（第四节的 28、30、37、39、49、51 分别对应权威编号的 71、73、32、34、44、46；13 与 78 两套恰好一致）。本卡不改本文件（D1 已产出的内容不重做），改为把对照表写进 `checklist-judgments.md` 的开头。根因是 `checklist.md` 正文不写行号，只有 `matrix.md` 记着这套编号——**一份没有自带编号的清单，被第二份文件按位次引用时必然分叉**。
- **第四版之后，清单的文件顺序与行号进一步脱钩。** 第 79–91 行同样各放所属组末尾，于是「感知」组的行号顺序成了 1–16、69、70、79、84、85。只读 `checklist.md` 已经无法还原任何一行的号。这是上一条的直接后果，记在这里是因为它会随每一版继续放大。
- **卡面的验收算术与卡面的指令对不上，本卡按指令做。** 卡说「不入表」一节的条数等于残差总数减 13，即 41−13＝28；但按同一张卡的指令，13 条新行实际占用 14 条残差（「投影单元与检查点缓存」由两条合成），第 60 行的改写又并入 3 条，进表共 17 条，余 24 条。本卡取指令、不取算术，并把这笔账写进 `checklist.md` 那一节的开头，好让读者自己核对。
- **`list_pull_requests` 的 `merged` 字段对本仓库 #1–#9 全部返回 false，而它们的合并提交确实在 `main` 的历史里。** 读 PR 是否落地时不能只看这个字段，要么看 `state` 加合并提交，要么直接查 `git log`。本卡合并 #10 时用的是返回 `"merged":true` 的那条路径，与前九个 PR 的记录形态不同。
- **「给出该行原文」这件事会撞上 Markdown 的行内代码。** `positions.md` 第 2 处要引的那行源码里本身含反引号（模板字符串），单反引号的行内代码会当场断掉，得改用双反引号包起来。凡是「照抄一行源码」的产物都要先看这一行有没有反引号。
