---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/core/system-prompt
---

# packages/core/system-prompt

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、60 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/core/system-prompt/README.md

系统提示装配包的英文说明文档，描述配置字段、注册方式与模型可见文本，供使用者与维护者阅读。

- 无运行期机制

### packages/core/system-prompt/package.json

该包的 npm 清单，声明入口、导出与发布内容。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定默认解析到的运行期文件（[packages/core/system-prompt/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/package.json#L14-L15)）
- `exports` 只开放三个子路径：`.` → `lib/index.js`、`./invariant` → `lib/invariant.js`、`./src/*` 直通源码，另加 `./package.json`（[packages/core/system-prompt/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/core/system-prompt/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/package.json#L28-L32)）
- `type: "module"` 使包内 `.js` 按 ESM 加载（[packages/core/system-prompt/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/package.json#L13)）

### packages/core/system-prompt/src/index.ts

包主入口：定义 `SystemPrompt` 服务、提示段/动态上下文/工具 schema/变量的注册表，以及每步调用一次的装配与渲染函数。

- `FIRST_PARTY_SECTION_ORDER` 给仓库自有各提示段固定整数位次（身份 −1000 到结构化输出 9900），这些数值决定拼接先后（[packages/core/system-prompt/src/index.ts:130-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L130-L161)）
- 导出 `PERSONA_SECTION` 名与 `PERSONA_ORDER` 位次，使另一处注册同名段构成遮蔽而非重复（[packages/core/system-prompt/src/index.ts:169-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L169-L172)）
- `VARIABLE_NAME` 与 `GROUP_AT` 两个正则界定合法变量名和一次完整的 `{{...}}` 引用（[packages/core/system-prompt/src/index.ts:175-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L175-L178)）
- `TOOL_ORDER_REST` 定义未列出工具的插入标记字符串 `<unlisted-tools>`（[packages/core/system-prompt/src/index.ts:181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L181)）
- `validateToolOrder` 在构造时对配置的工具顺序查重名并要求含有 rest 标记，两者任一不满足直接抛错（[packages/core/system-prompt/src/index.ts:187-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L187-L198)）
- `orderTools` 发现 provider 返回了保留名 `<unlisted-tools>` 时抛错（[packages/core/system-prompt/src/index.ts:206-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L206-L209)）
- 未配置顺序时 `orderTools` 就地按工具名排序（[packages/core/system-prompt/src/index.ts:210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L210)）
- 配置里出现不在 `knownNames` 中的名字时抛错，并在消息里列出已知工具名（[packages/core/system-prompt/src/index.ts:211-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L211-L214)）
- 未被列出的工具按名排序后整体插入 rest 标记所在位置，其余按配置列表逐名展开（[packages/core/system-prompt/src/index.ts:215-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L215-L219)）
- `compareNames` 用代码单元比较而非本地化比较，使排序结果与机器无关（[packages/core/system-prompt/src/index.ts:222-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L222-L224)）
- `comparePromptSections` 先按 `order` 再按名字排序提示段（[packages/core/system-prompt/src/index.ts:227-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L227-L229)）
- `compareToolNames` 按名字排序工具 schema（[packages/core/system-prompt/src/index.ts:232-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L232-L234)）
- `renderPrompt` 对每段做变量插值、丢掉渲染后为空的段、用空行连接剩余段落，产出最终系统提示文本（[packages/core/system-prompt/src/index.ts:263-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L263-L268)）
- `joinContextSections` 在有非空内容时给快照加固定前缀句 `Current runtime context. This snapshot supersedes earlier runtime-context snapshots.`，无内容则返回空串（[packages/core/system-prompt/src/index.ts:287-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L287-L291)）
- `renderContextSections` 逐条插值动态上下文并滤掉渲染为空的条目，保留贡献者名字（[packages/core/system-prompt/src/index.ts:302-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L302-L306)）
- `interpolate` 从左向右扫描 `{{`，若该处不是完整引用组且后文还存在 `}}` 则抛错，否则把这两个字符当字面量原样输出（[packages/core/system-prompt/src/index.ts:317-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L317-L327)）
- 引用名不匹配变量名正则（含 `{{}}` 空名）时抛错（[packages/core/system-prompt/src/index.ts:329-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L329-L332)）
- 用 `Object.hasOwn` 判定变量是否注册，未注册则抛错并列出已注册名，避免经原型链解析（[packages/core/system-prompt/src/index.ts:333-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L333-L337)）
- 已注册但本次取值为 `undefined` 的变量抛错（[packages/core/system-prompt/src/index.ts:338-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L338-L341)）
- 替换后扫描位置跳到引用组之后，代入的值不再被二次扫描（[packages/core/system-prompt/src/index.ts:342-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L342-L345)）
- `PromptLayer` 为一层持有段、上下文、运行期上下文抑制器、工具 provider、变量五类注册容器，并按全局/作用域给出不同的重名错误文案（[packages/core/system-prompt/src/index.ts:355-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L355-L376)）
- `PromptLayer.isEmpty` 以五类容器全空为判据，供层的回收使用（[packages/core/system-prompt/src/index.ts:378-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L378-L385)）
- `SystemPrompt.Config` 定义四个配置字段与默认值，其中 `toolOrder` 默认保留为 `undefined` 以区别于显式空数组（[packages/core/system-prompt/src/index.ts:390-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L390-L396)）
- 分层容器在任何注册变动时触发回调，向上下文 `emit('system-prompt/change')`（[packages/core/system-prompt/src/index.ts:398-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L398-L401)）
- 构造时校验并保存 `toolOrder`（[packages/core/system-prompt/src/index.ts:404-406](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L404-L406)）
- `includeHarnessIdentity` 为真时注册名为 `harness:identity`、位次 −1000 的固定文本段 `You are an AI agent powered by DeepSeek Harness.`（[packages/core/system-prompt/src/index.ts:407-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L407-L414)）
- 无论是否为空都注册 `deployment:persona` 段，文本取自配置（[packages/core/system-prompt/src/index.ts:415-420](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L415-L420)）
- `includeRuntimeContext` 为假时在构造中登记一个运行期上下文抑制器（[packages/core/system-prompt/src/index.ts:421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L421)）
- `section()` 拒绝非有限的 `order` 并抛 `TypeError`（[packages/core/system-prompt/src/index.ts:432-435](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L432-L435)）
- `section()` 把段插入调用上下文所属层并返回该 effect 的 disposer（[packages/core/system-prompt/src/index.ts:436-440](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L436-L440)）
- `context()` 同样拒绝非有限 `order` 并把动态上下文插入调用方所属层，返回 disposer（[packages/core/system-prompt/src/index.ts:449-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L449-L458)）
- `suppressRuntimeContext()` 在调用方所属层追加一个抑制标记，多个抑制器各自可独立释放（[packages/core/system-prompt/src/index.ts:466-472](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L466-L472)）
- `tools()` 在调用方所属层追加一个每次装配都会被求值的工具 schema provider（[packages/core/system-prompt/src/index.ts:481-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L481-L487)）
- `variable()` 先用正则校验变量名，不合法即抛错，然后把取值函数插入所属层（[packages/core/system-prompt/src/index.ts:497-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L497-L506)）
- `assemble()` 取全局层与作用域链层，只要任一层存在抑制器就把本次装配标记为抑制运行期上下文（[packages/core/system-prompt/src/index.ts:518-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L518-L522)）
- 变量先解析全局层，再按作用域链由远及近覆盖同名值，使最近的作用域胜出（[packages/core/system-prompt/src/index.ts:523-533](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L523-L533)）
- 段与动态上下文按名字合并，作用域内的同名注册遮蔽全局注册（[packages/core/system-prompt/src/index.ts:534-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L534-L536)）
- 工具 provider 取全局层加作用域链上各层，两者都参与贡献而非互相遮蔽（[packages/core/system-prompt/src/index.ts:537-541](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L537-L541)）
- 每个 provider 的返回 schema 被重建为只含 `name`/`description`/`parameters` 三个字段，且 `parameters` 经 `structuredClone` 与源对象脱钩（[packages/core/system-prompt/src/index.ts:544-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L544-L550)）
- `knownNames` 取 provider 显式给出的名字集合，缺省时退回本次可见 schema 的名字，用于工具顺序校验（[packages/core/system-prompt/src/index.ts:551-554](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L551-L554)）
- 排序后若存在一个以上 `complete: true` 的段则抛错并列出这些段名（[packages/core/system-prompt/src/index.ts:555-559](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L555-L559)）
- 逐段解析文本（函数型段以本次装配上下文调用），并把 `complete` 段的解析结果单独留一份副本（[packages/core/system-prompt/src/index.ts:560-569](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L560-L569)）
- 装配对象中，动态上下文在抑制时直接为空数组，否则按 `order` 升序排序并逐条解析文本（[packages/core/system-prompt/src/index.ts:570-579](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L570-L579)）
- 工具在进入 waterfall 之前先经 `orderTools` 定序（[packages/core/system-prompt/src/index.ts:580-582](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L580-L582)）
- 以作用域为目标 emit `system-prompt/assemble` waterfall，把可变装配和调用方上下文交给监听者，取其返回值（[packages/core/system-prompt/src/index.ts:583-586](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L583-L586)）
- waterfall 之后：存在 `complete` 段则用它覆盖全部段落，抑制状态下强制把上下文清空，其余字段保留监听者的结果（[packages/core/system-prompt/src/index.ts:587-592](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L587-L592)）
- 默认导出 `SystemPrompt` 类，使该模块作为服务插件被挂载（[packages/core/system-prompt/src/index.ts:596](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/index.ts#L596)）

### packages/core/system-prompt/src/invariant.ts

该包的不变量伴生插件，挂在装配 waterfall 上校验最终装配结果。

- 导出插件名 `system-prompt-invariant` 与 `inject = ['invariants']`，后者要求不变量服务先就绪才装载本插件（[packages/core/system-prompt/src/invariant.ts:10-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/invariant.ts#L10-L13)）
- 校验装配后的段：名字非空、不重复、文本为字符串，违例即上报（[packages/core/system-prompt/src/invariant.ts:17-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/invariant.ts#L17-L23)）
- 对动态上下文做同样的非空、不重名、文本为字符串检查（[packages/core/system-prompt/src/invariant.ts:25-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/invariant.ts#L25-L31)）
- 检查每个工具 schema 的名字非空（[packages/core/system-prompt/src/invariant.ts:33-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/invariant.ts#L33-L35)）
- 检查每个变量名匹配 `^[a-z][a-z0-9_]*$`，且值为字符串或 `undefined`（[packages/core/system-prompt/src/invariant.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/invariant.ts#L37-L42)）
- 以 `global: true, prepend: true` 挂在 `system-prompt/assemble` 上，先 `await next()` 拿到链末结果再校验，并原样返回该结果（[packages/core/system-prompt/src/invariant.ts:46-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/invariant.ts#L46-L52)）
- `apply` 用包名向 `ctx.invariants` 注册这个安装器并返回其 disposer（[packages/core/system-prompt/src/invariant.ts:59-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/system-prompt/src/invariant.ts#L59-L60)）

### packages/core/system-prompt/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、声明输出目录与工作区项目引用。

- 无运行期机制
