---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/goal/command-goal
---

# packages/goal/command-goal

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、27 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/goal/command-goal/README.md

该包的说明文档，描述 `/goal` 各子命令的效果、输入语法、图片附件处理与组合方式。

- 无运行期机制

### packages/goal/command-goal/package.json

该包的 npm 清单，声明入口、导出映射、发布文件集与依赖。

- `main`/`types` 与 `exports` 决定运行期可被解析的入口：根导出指向 `lib/index.js`，`./invariant` 指向 `lib/invariant.js`，另开放 `./src/*` 与 `./package.json`（[packages/goal/command-goal/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/package.json#L14-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/goal/command-goal/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/package.json#L28-L32)）

### packages/goal/command-goal/src/index.ts

`/goal` 命令的实现文件：解析人类输入的子命令语法、调用持久化目标服务、渲染直出的状态与错误文本，并在创建/编辑时提交图片附件。

- 插件名与注入声明：依赖 `commands` 与 `goals` 两个服务（[packages/goal/command-goal/src/index.ts:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L12-L13)）
- 固定用法文本，出现在无目标时的展示与若干错误里（[packages/goal/command-goal/src/index.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L15)）
- `assertNever` 对未处理的联合成员抛 `TypeError`（[packages/goal/command-goal/src/index.ts:28-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L28-L30)）
- `parseGoalCommand` 只在控制词独占整条输入时识别 `clear`/`pause`/`resume`/`edit`，空输入是展示，其余任意文本一律当作目标描述（[packages/goal/command-goal/src/index.ts:34-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L34-L44)）
- `edit` 后接空白时按前缀匹配并把其后内容修剪成新目标描述（[packages/goal/command-goal/src/index.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L42)）
- `phaseLabel` 把持久化阶段映射成人类可读标签（[packages/goal/command-goal/src/index.ts:47-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L47-L56)）
- `commandHint` 按当前阶段与激活状态给出该状态下有意义的命令清单（活跃且已武装给 pause，活跃未武装给 resume，已完成只给新建与清除）（[packages/goal/command-goal/src/index.ts:59-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L59-L74)）
- `renderGoal` 输出标题、状态、可选阻塞原因、目标描述、轮次计数与上限、激活状态与可用命令，且不输出内部 id 与修订号（[packages/goal/command-goal/src/index.ts:77-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L77-L95)）
- 阻塞态缺少原因时抛 `TypeError`（[packages/goal/command-goal/src/index.ts:79-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L79-L80)）
- `goalRef` 用当前视图的 id 与修订号构造比较并设置所需的引用（[packages/goal/command-goal/src/index.ts:98-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L98-L100)）
- `missingGoal` 为需要现存目标的操作返回带用法的固定错误文本（[packages/goal/command-goal/src/index.ts:103-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L103-L108)）
- `submitObjectiveAttachments` 把本次调用被准入的图片块加上一条固定说明文本，作为一条普通用户消息 followup 提交，使后续轮次能从会话历史读到它们（[packages/goal/command-goal/src/index.ts:116-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L116-L122)）
- 带图片但子命令不是创建或编辑时直接返回错误，不做任何变更也不提交消息（[packages/goal/command-goal/src/index.ts:127-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L127-L132)）
- 展示分支：无目标时返回"未设置目标"加用法，否则渲染当前目标（[packages/goal/command-goal/src/index.ts:136-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L136-L139)）
- 裸 `edit` 返回"需要给出替换目标描述"的错误（[packages/goal/command-goal/src/index.ts:140-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L140-L141)）
- 创建分支：已存在且未完成的目标会拒绝创建并提示改用 edit 或先 clear；否则调用服务创建、提交附件并渲染（[packages/goal/command-goal/src/index.ts:142-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L142-L152)）
- 编辑分支：无目标报错；目标已完成时改为新建一个全新身份；否则以当前引用做比较并设置的编辑，三条路径成功后都提交附件（[packages/goal/command-goal/src/index.ts:153-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L153-L163)）
- 暂停与恢复分支：无目标报错，否则以当前引用调用服务并渲染新状态（[packages/goal/command-goal/src/index.ts:164-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L164-L169)）
- 清除分支：无目标时返回"无可清除"，否则以当前引用清除并返回固定成功文本（[packages/goal/command-goal/src/index.ts:170-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L170-L173)）
- 目标域抛出的领域错误被转成一条固定的命令错误文本，其他异常继续上抛使分发失败（[packages/goal/command-goal/src/index.ts:177-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L177-L185)）
- `apply` 向命令注册表登记名为 `goal` 的命令，附带描述、输入提示与 `images: true`（声明支持图片附件），处理器指向上面的执行函数（[packages/goal/command-goal/src/index.ts:189-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/index.ts#L189-L196)）

### packages/goal/command-goal/src/invariant.ts

该包的不变量伴随插件，向不变量服务登记包名并安装一个空检查器。

- 声明伴随插件名与对 `invariants` 服务的注入（[packages/goal/command-goal/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/invariant.ts#L13-L15)）
- 以包名注册一个空安装器，并返回注册的释放函数（[packages/goal/command-goal/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/command-goal/src/invariant.ts#L21-L29)）

### packages/goal/command-goal/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工作区引用。

- 无运行期机制
