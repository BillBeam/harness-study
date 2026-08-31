---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-settings-models
---

# packages/client/ui-settings-models

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 28 个文件、223 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-settings-models/README.md

包 README，用散文描述模型设置页的用法、提供方卡片、密钥写入路径、首启对话框顺序与两个扩展槽。

- 无运行期机制

### packages/client/ui-settings-models/package.json

包清单，声明该浏览器端插件的模块类型、入口映射、注入依赖与发布文件集。

- 声明 ESM 模块类型，并把包主入口与类型入口指向打包产物 `lib/index.js` / `lib/types/index.d.ts`（[packages/client/ui-settings-models/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/package.json#L13-L15)）
- `exports` 开放五个解析入口：根、`./invariant`、`./client`、`./src/*` 源码直读与 `./package.json`（[packages/client/ui-settings-models/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/package.json#L16-L31)）
- `dsh.client.inject` 列出该插件加载时需要的三个客户端包，`platform` 限定为 `web`（[packages/client/ui-settings-models/package.json:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/package.json#L32-L41)）
- `files` 把发布内容限定为三个打包产物与类型声明（[packages/client/ui-settings-models/package.json:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/package.json#L69-L74)）

### packages/client/ui-settings-models/src/client/CustomProviderCard.tsx

自定义提供方创建卡片，由 `ModelsSection` 在"添加自定义提供方"分支渲染，把用户手写的路由写入 `llm-pi-ai` 命名空间。

- 把所有手工声明的路由固定写入 `llm-pi-ai` 这一个设置命名空间（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L38)）
- `ROUTE_PATTERN` 要求路由 id 以小写字母开头、其后为小写字母数字与短横线段（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L48)）
- 卡片打开时冻结当时的 section revision，之后的创建写入都携带它（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L80)）
- 协议下拉的初值取适配器上报的第一个协议（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L84)）
- profile 写入成功后置 `committed`，据此把除密钥外的所有字段变为不可编辑（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:94-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L94-L97)）
- 路由 id 分别判定格式非法与已被占用（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:99-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L99-L101)）
- 模型行用共享的逐行校验函数判定，密钥用共享的密钥判定函数（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:104-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L104-L105)）
- 密钥取输入去首尾空白后的值，空串表示"未提供密钥"（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L109)）
- `ready` 要求路由非空且合法且未占用、baseURL 非空、至少一个模型且逐行校验通过、密钥判定通过（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:110-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L110-L112)）
- `hint` 在已就绪、已有失败、密钥字段自带失败或路由门未过时不渲染，否则按 baseURL、模型行、模型数量的顺序选一条（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:115-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L115-L129)）
- 从路由 id 派生凭据引用名（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L133)）
- 组装的 profile 只在 displayName 非空时带该字段，只在实际要存密钥时写入 `apiKeyEnv`，并固定带上 `api`、`baseURL` 与逐行复制的 `models`（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:136-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L136-L146)）
- 一次 `settings.mutate` 把整个 profile set 到 `providers.<route>`，并携带打开时的 revision，使并发声明变成冲突拒绝（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:150-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L150-L155)）
- 写入成功后置 `committed`，使随后的重试跳过 mutate 直接重发凭据写入（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L160)）
- 密钥经 `credentials.set` 单独写入，失败只返回该阶段的消息（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:162-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L162-L167)）
- `create` 包住 busy 与失败态：成功调 `onClose(true)`，传输层拒绝时把异常转成消息，finally 解除 busy（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:171-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L171-L188)）
- 路由 id 非法或占用时渲染错误行，否则渲染说明行（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:209-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L209-L211)）
- 显示名输入的占位符在路由已填时改用路由 id（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L218)）
- 密钥输入为 password 且关闭自动填充，空白失败在此改用"新建"文案（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:250-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L250-L265)）
- 传给模型列表编辑器的探测目标由当前表单的 baseURL、协议与未保存的密钥组成，密钥判定失败时阻断探测（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:267-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L267-L280)）
- 提交按钮在只读、进行中或未就绪时禁用（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L288)）
- 取消时把 `committed` 作为 changed 上报，使已写入 profile 的取消仍触发上层刷新（[packages/client/ui-settings-models/src/client/CustomProviderCard.tsx:291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/CustomProviderCard.tsx#L291)）

### packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx

直连 DeepSeek 适配器的模型目录编辑器，同时导出容量解析/格式化与逐行校验函数，被 `ProviderEditor`、`ModelListEditor` 与 `CustomProviderCard` 共用。

- 容量文本的接受形状为可带小数的数字加可选 K/M 后缀，缩放按十进制 1000 / 1000000（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:31-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L31-L34)）
- `parseCapacity` 空文本返回 undefined、不匹配返回 NaN，缩放后对接近整数的结果做四舍五入吸附（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:43-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L43-L55)）
- `formatCapacity` 只对正整数做 M/K 缩写，其余原样输出（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:64-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L64-L69)）
- `modelDrafts` 把非数组值变成空数组、把非对象条目变成空对象，保留对象条目的全部字段（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:81-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L81-L87)）
- `validateDeepSeekModels` 对 undefined 直接放行，逐行检查 id 去空白后非空、去空白后不重复、name 为非空字符串、contextWindow 与 maxTokens 为正整数，返回首个失败的行号与文案键（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:94-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L94-L123)）
- `update` 逐行浅拷贝后写入或在值为 undefined 时删除该键，再整体上报（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:166-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L166-L175)）
- 删除一行时同步重排编辑缓冲键与展开集合的行号，再上报去掉该行的数组（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:177-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L177-L197)）
- 恢复默认清空两个按行号索引的本地状态并调用 `onReset` 撤销用户层覆盖（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:199-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L199-L203)）
- 容量字段优先显示按行按字段的按键缓冲，无缓冲时显示格式化后的存储值（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:214-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L214-L219)）
- 失焦时只在解析结果不是 NaN 时丢弃缓冲，不可读文本留在屏幕上（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:221-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L221-L234)）
- 容量输入的占位符在有继承默认值时显示该值的格式化文本，否则显示"使用提供方默认值"（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:250-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L250-L252)）
- 容量输入每次改动同时写入缓冲与解析后的存储值（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:255-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L255-L259)）
- 目录状态文字与"恢复默认"按钮只在用户层已覆盖时出现（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:270-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L270-L285)）
- 模型 id 在失焦时才做去空白写回（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:302-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L302-L307)）
- 显示名清空时写入 undefined，即从该行删除该字段（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:316-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L316-L318)）
- 添加模型在复制既有行之后追加一个 id 为空串的新行（[packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx:357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekModelsEditor.tsx#L357)）

### packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.module.css

首启 DeepSeek 对话框的 CSS Module，只有描述段与编辑器区的排版规则。

- 无运行期机制

### packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx

首启的官方 DeepSeek 凭据步骤组件，由 `index.ts` 注册进 `settings.onboarding` 槽，读同一份模型页 join 快照。

- 从共享的模型页快照推导首启就绪状态（[packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx#L55)）
- 快照仍为 idle 时触发一次共享 controller 的加载（[packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx:57-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx#L57-L59)）
- 就绪状态为适配器缺席、已有可用提供方或不可用时直接调用 `complete()` 结束该步（[packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx:61-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx#L61-L67)）
- 只有 `credential-missing` 才继续渲染，其余分支返回 null，未知分支走 `assertNever`（[packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx:69-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx#L69-L80)）
- 在快照中按 `deepseek-official` + `llm-deepseek` + 空设置路径定位那一行与其命名空间，缺一则不渲染（[packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx:82-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx#L82-L88)）
- 编辑器关闭时：未提交则结束该步，已提交则只重新加载共享快照（[packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx:90-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx#L90-L96)）
- 以 `credentialOnly`、`credentialRequired`、`autoFocusCredential`、`readOnly=false` 复用提供方编辑器，并覆盖取消/提交/进行中三个文案键（[packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx:102-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/DeepSeekOnboardingDialog.tsx#L102-L119)）

### packages/client/ui-settings-models/src/client/EditorFooter.tsx

所有提供方卡片共用的取消/提交动作行组件。

- 取消按钮只在提交进行中禁用，只读时仍可点击（[packages/client/ui-settings-models/src/client/EditorFooter.tsx:49-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/EditorFooter.tsx#L49-L56)）
- 取消文案键在未指定时回落到 `cancel`（[packages/client/ui-settings-models/src/client/EditorFooter.tsx:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/EditorFooter.tsx#L55)）
- 提交按钮的禁用完全由调用方给出的 `submitDisabled` 决定（[packages/client/ui-settings-models/src/client/EditorFooter.tsx:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/EditorFooter.tsx#L60)）
- 提交进行中时把标签换成调用方给出的进行中文案（[packages/client/ui-settings-models/src/client/EditorFooter.tsx:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/EditorFooter.tsx#L63)）

### packages/client/ui-settings-models/src/client/ModelListEditor.tsx

pi-ai 提供方 profile 的模型列表编辑器，附带向端点询问可用模型的动作，被 `ProviderEditor` 与 `CustomProviderCard` 使用。

- `textOf` / `numberOf` 只在字段类型匹配时取值，否则给出空串或 undefined（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:34-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L34-L43)）
- 两个容量字段的空值占位符固定为 `256K` 与 `32K`（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:128-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L128-L131)）
- 采纳一个候选模型时只带上它实际给出的 name、contextWindow 与 maxTokens（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:145-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L145-L152)）
- 容量编辑同时写入按"行号:字段"索引的按键缓冲和解析后的存储值（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:177-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L177-L186)）
- 删除行时把缓冲键中大于该行号的部分整体前移一位（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:188-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L188-L201)）
- `patch` 先把新值展开进原行以保留未编辑字段，再把值为 undefined 或空串的键从该行删除（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:211-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L211-L226)）
- 询问模型走 `llm.discoverModels`，请求体只带表单实际给出的 provider、非空 baseURL、协议与未保存的密钥（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:228-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L228-L237)）
- 询问失败或返回空列表都落到失败文案而不写入任何配置（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:238-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L238-L246)）
- 询问结果放进候选选择器，默认只勾选当前列表中尚不存在的 id（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:247-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L247-L251)）
- 传输层拒绝时把异常转成失败消息，finally 解除 busy（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:252-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L252-L258)）
- 采纳所选按 id 合并：已存在的行保留原值，不被候选覆盖（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:266-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L266-L280)）
- 全选按钮在已全选时改为清空勾选（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:291-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L291-L300)）
- 只有带 provider 或带非空 baseURL 的表单才被判为可询问（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L304)）
- 覆盖状态文字与重置按钮只在传入 `overridden` 时渲染（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:310-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L310-L329)）
- 询问按钮在禁用、进行中、不可询问或密钥被判定阻断时禁用，并用 title 说明原因（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:330-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L330-L340)）
- 列表为空时渲染"选择器中不显示任何模型"的说明（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L342)）
- 显示名清空时以 undefined 写入，即从该行删除该字段（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L362)）
- 删除一行时同时前移 expanded 集合与编辑缓冲的行号（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:374-398](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L374-L398)）
- 两个容量输入只在该行展开时渲染，改动走容量编辑路径（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:400-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L400-L431)）
- 添加模型追加一个 id 为空串的新行（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:434-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L434-L441)）
- 候选对话框只在有候选时打开，只有"添加所选"会写回列表，取消清空候选与勾选（[packages/client/ui-settings-models/src/client/ModelListEditor.tsx:443-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelListEditor.tsx#L443-L479)）

### packages/client/ui-settings-models/src/client/ModelsSection.module.css

模型设置页的 CSS Module，定义行卡片、编辑器、模型列表、按钮与对话框的排版与配色变量引用。

- 无运行期机制

### packages/client/ui-settings-models/src/client/ModelsSection.tsx

模型设置页主体组件，把提供方目录、设置命名空间与凭据状态 join 成行，并一次只展开一张编辑卡；由 `index.ts` 注册到 `settings.section` 槽。

- 渲染提供方编辑器时只在目标标记为 declared 时透传该 prop（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:89-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L89-L99)）
- 删除提供方先 `credentials.unset`（仅当存在受管引用），再以一条 unset 路径操作删除该 profile，任一步失败返回消息，传输拒绝转成消息，全部成功后重新加载（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:112-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L112-L135)）
- `needsSetup` 只在没有任何可用提供方、该行是整段提供方且凭据未确认配置时才成立（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:146-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L146-L150)）
- 卡片扩展槽的凭据事实：profile 命名了引用就看该引用状态，否则看派生引用的状态（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:159-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L159-L163)）
- 只有 profile 的 `apiKeyEnv` 恰为本页派生名、且该凭据已配置且可写时，删除目标才携带凭据引用（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:165-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L165-L181)）
- 提供方标签在 id 与显示名不同时拼成 "显示名 (id)"，并用于替换破坏性操作文案里的占位符（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:184-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L184-L193)）
- 任一注入依赖缺失时整个 section 渲染 null（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:200-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L200-L207)）
- 保存成功的公告先等一次重新加载完成再置提示，使提示读到刷新后的目录名（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:221-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L221-L226)）
- 关闭行编辑卡同时清掉 editing / adding / declaring 三个状态（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:228-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L228-L233)）
- 关闭首启 setup 卡只把该 provider 记入本会话的已关闭集合，不动其它卡片的草稿状态（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:242-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L242-L245)）
- 删除进行中拒绝关闭确认对话框（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:247-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L247-L251)）
- 确认删除后失败则把消息留在对话框内、目标保持打开，成功才清空目标（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:253-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L253-L267)）
- 快照为 idle 时在渲染中触发一次加载（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L269)）
- 加载失败时整页换成错误文案加重试按钮（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:270-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L270-L281)）
- 保存提示按路由 id 在刷新后的行里重新取名，行已消失则回退到关卡时捕获的身份（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:287-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L287-L292)）
- 从快照派生"是否已有可用提供方"、已配置行与可添加行（可添加行要求未配置且命名空间非空）（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:296-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L296-L298)）
- 添加卡片的目标行在刷新中消失时，草稿卡保留而扩展槽不再派发（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:299-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L299-L306)）
- 可选协议从 `llm-pi-ai` 命名空间的 schema 读出（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L310)）
- 设置文档不可写且已加载完成时渲染只读提示（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L316)）
- 保存成功提示以 `role="status"` / `aria-live="polite"` 渲染，只含提供方名（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:317-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L317-L323)）
- 首启姿态下该行整体被 setup 卡替代，并同样派发以 settingsNs 为键的卡片扩展槽（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:330-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L330-L350)）
- 行的展开状态要求当前不在添加态且 editing 命中该 provider；缺失圆点只在 profile 命名了引用且该引用被确认缺失时出现（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:352-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L352-L356)）
- 自定义标签只在适配器报告该路由为手工声明时渲染（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:365-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L365-L367)）
- 两种凭据圆点带 `role="img"` 与可访问标签，只在确认已配置或确认缺失时渲染（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:368-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L368-L386)）
- 编辑按钮清掉保存提示与另外两种卡片状态，再切换本行的展开（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:389-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L389-L404)）
- 删除按钮只在该行被标记为可删除时渲染，且在不可写时禁用（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:405-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L405-L421)）
- 每个已配置行都派发一次卡片扩展槽，owner 载荷为目录行、是否已配置与凭据是否已配置，键为 settingsNs（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:424-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L424-L428)）
- 添加卡片用一个只列可添加行的 select 切换编辑目标，编辑器以目标 provider 为 React key 从而换目标即重建草稿（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:444-478](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L444-L478)）
- 声明态渲染自定义提供方卡片，传入已占用的 id 列表、协议列表与 `llm-pi-ai` 当前 revision，关闭时若已变更则重新加载（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:488-505](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L488-L505)）
- 两个添加按钮分别在没有可添加行、没有可用协议或文档不可写时禁用，点击时互相清掉对方的卡片状态（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:511-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L511-L543)）
- 在行与添加控件之后派发列表型 footer 扩展槽（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L546)）
- 删除确认对话框按目标是否带凭据引用切换描述文案，删除进行中禁用两个按钮并把标签换成进行中文案（[packages/client/ui-settings-models/src/client/ModelsSection.tsx:547-580](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ModelsSection.tsx#L547-L580)）

### packages/client/ui-settings-models/src/client/OnboardingModal.module.css

首启对话框外壳的 CSS Module，只有宽度、内边距、标题与正文排版。

- 无运行期机制

### packages/client/ui-settings-models/src/client/OnboardingModal.tsx

本包注册的两个首启步骤共用的模态外壳组件。

- `onClose` 传入空函数，使遮罩点击与 Esc 等隐式关闭不生效（[packages/client/ui-settings-models/src/client/OnboardingModal.tsx:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/OnboardingModal.tsx#L8)）
- 挂载时把 id 为 `root` 的应用根节点设为 inert，卸载时还原原值（[packages/client/ui-settings-models/src/client/OnboardingModal.tsx:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/OnboardingModal.tsx#L26-L32)）
- `focusTitle` 为真时把焦点移到标题元素（[packages/client/ui-settings-models/src/client/OnboardingModal.tsx:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/OnboardingModal.tsx#L34-L36)）
- 模态恒为打开状态并以 headless 模式渲染（[packages/client/ui-settings-models/src/client/OnboardingModal.tsx:39-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/OnboardingModal.tsx#L39-L45)）
- 只有在 `focusTitle` 时才给标题加上 `tabIndex={-1}` 使其可聚焦（[packages/client/ui-settings-models/src/client/OnboardingModal.tsx:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/OnboardingModal.tsx#L47)）

### packages/client/ui-settings-models/src/client/ProviderEditor.tsx

单个提供方的编辑卡片，被行编辑、首启 setup 姿态、添加卡片与官方 DeepSeek 首启步骤共用。

- DeepSeek 家族的 baseURL 占位符固定为公开端点常量（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L45)）
- 草稿由用户层子树 `structuredClone` 得到，子树不是普通对象时草稿为空（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:92-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L92-L100)）
- `pathOps` 逐键做 JSON 比较产出 set 操作，并为 before 有而 after 无的键产出 unset，未被卡片观察到的字段不产生任何操作（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:112-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L112-L129)）
- 布局按命名空间选定：`llm-deepseek`、`llm-pi-ai`，其余为 unknown（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:132-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L132-L136)）
- 凭据引用取生效 profile 的 `apiKeyEnv`，为空时用路由 id 派生（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:139-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L139-L150)）
- 提交重试的两个基线（已提交原值与期望 revision）在卡片打开时各取一次快照（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:167-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L167-L170)）
- 从序列化 schema 复原根节点、定位本 profile 的 schema 节点，并取生效值作为回落（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:171-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L171-L173)）
- 只读或提交进行中统一禁用字段（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L174)）
- 只有 pi-ai 布局才从命名空间 schema 读取可选协议，其余布局得到空列表（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:181-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L181-L184)）
- 挂载与引用变化时用该引用调 `credentials.describe` 取凭据状态，带 stale 守卫，被拒或失败时静默不设状态（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:186-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L186-L201)）
- 读字段时把纯空白视为不存在，写字段时把纯空白值从草稿中删除而非写入（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:203-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L203-L216)）
- 模型行用共享逐行校验判定，密钥用共享密钥判定，密钥取值为去首尾空白后的字符串（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:220-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L220-L226)）
- 要求必填凭据时，输入非空但去空白后为空报"必须输入密钥"，该失败优先于通用密钥失败（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:227-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L227-L231)）
- 探测目标由草稿优先、生效值兜底的 api 与 baseURL 组成，固定带上路由 id，密钥非空时才带上（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:234-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L234-L244)）
- pi-ai 布局且两层都未命名引用、且本次要存密钥时，把派生引用名写进待提交的 profile（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:255-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L255-L258)）
- 非凭据模式的提交先跑一次模型逐行校验，再在整段路径下跑一次 schema 校验（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:259-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L259-L274)）
- 凭据模式不产生任何设置操作；pi-ai 新建且草稿为空时写入一个空对象 profile；其余情况用最小路径操作集（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:275-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L275-L283)）
- 操作集非空才发 `settings.mutate` 并携带期望 revision，冲突码换成本地文案，成功后立即推进两个重试基线与草稿（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:284-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L284-L294)）
- 密钥非空时在设置提交之后单独 `credentials.set`，全部成功后清空密钥输入（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:295-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L295-L300)）
- 提交包住 busy 与失败态，成功调 `onClose(true)`，传输拒绝转成消息，finally 解除 busy（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:303-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L303-L321)）
- schema 节点无法解析时整卡换成一行错误文案（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:323-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L323-L327)）
- 凭据被报告为不可写时锁定密钥输入（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L329)）
- 继承模型取组合层的固定值，没有则取 schema 节点的默认值，不读生效值（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:338-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L338-L341)）
- 只有 pi-ai 家族且被报告为手工声明的路由才拥有可编辑的显示名与协议字段（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L352)）
- 模型行在用户层已覆盖时取草稿值，否则取继承值（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:353-355](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L353-L355)）
- 密钥占位符三态：不可写时显示环境锁定文案、已配置且非必填时显示"已配置"、否则按家族给出两种输入提示（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:356-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L356-L362)）
- 目录编辑器的写回路径：改动写入草稿的 `models`，重置从草稿删除该键（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:364-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L364-L373)）
- 密钥输入为 password、关闭自动填充，并按 props 决定 required、autoFocus 与是否被锁定禁用（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:376-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L376-L392)）
- 凭据模式下完全不渲染自定义设置折叠区（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L393)）
- 手工声明路由的显示名输入，其占位符取组合层的名字，没有则取路由 id（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:399-422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L399-L422)）
- baseURL 输入清空时写入 undefined；占位符在 deepseek 家族用公开端点，pi-ai 家族用生效值或默认文案（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:423-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L423-L438)）
- 手工声明路由的协议 select 在当前未命名协议时额外插入一个空值选项（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:441-463](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L441-L463)）
- deepseek 家族渲染带继承容量的目录编辑器，pi-ai 家族渲染带探测目标与阻断原因的模型列表编辑器（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:467-477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L467-L477)）
- unknown 布局只渲染一行提示文案并附上命名空间名（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:496-498](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L496-L498)）
- 模型行失败在非凭据模式下渲染成带行号的提示（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:500-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L500-L506)）
- 提交禁用条件为：只读或进行中、unknown 布局、非凭据模式下模型行失败、密钥失败、必填凭据却未填（[packages/client/ui-settings-models/src/client/ProviderEditor.tsx:507-519](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/ProviderEditor.tsx#L507-L519)）

### packages/client/ui-settings-models/src/client/WelcomeNotice.module.css

内测声明步骤的 CSS Module，只有正文段落、错误行与动作区的排版。

- 无运行期机制

### packages/client/ui-settings-models/src/client/WelcomeNotice.tsx

版本化内测声明步骤组件，由 `index.ts` 以 order -100 注册进 `settings.onboarding` 槽。

- 用 ref 保证 `complete()` 只被调用一次（[packages/client/ui-settings-models/src/client/WelcomeNotice.tsx:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/WelcomeNotice.tsx#L37-L42)）
- 状态为 idle 时触发一次确认状态加载（[packages/client/ui-settings-models/src/client/WelcomeNotice.tsx:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/WelcomeNotice.tsx#L44-L46)）
- 已确认时结束该步（[packages/client/ui-settings-models/src/client/WelcomeNotice.tsx:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/WelcomeNotice.tsx#L48-L50)）
- idle、加载中或已确认时不渲染任何内容（[packages/client/ui-settings-models/src/client/WelcomeNotice.tsx:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/WelcomeNotice.tsx#L52)）
- 只有确认写入返回成功才结束该步，失败时对话框留在原地（[packages/client/ui-settings-models/src/client/WelcomeNotice.tsx:54-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/WelcomeNotice.tsx#L54-L56)）
- 正文按空行拆成多个段落渲染（[packages/client/ui-settings-models/src/client/WelcomeNotice.tsx:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/WelcomeNotice.tsx#L57)）
- 写入失败时渲染带 `role="alert"` 的错误行（[packages/client/ui-settings-models/src/client/WelcomeNotice.tsx:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/WelcomeNotice.tsx#L64)）
- 保存进行中禁用继续按钮（[packages/client/ui-settings-models/src/client/WelcomeNotice.tsx:66-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/WelcomeNotice.tsx#L66-L73)）

### packages/client/ui-settings-models/src/client/apiKey.ts

浏览器端对输入的 API 密钥做字段级判定，被提供方编辑卡与自定义提供方创建卡共用。

- 合法字符集限定为可打印 ASCII（不含空格）（[packages/client/ui-settings-models/src/client/apiKey.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/apiKey.ts#L12)）
- 识别粘贴进来的 `NAME=value` 环境变量行：名字须全大写，且等号后不得再是等号（[packages/client/ui-settings-models/src/client/apiKey.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/apiKey.ts#L23)）
- 识别被同一种引号（双引号、单引号、反引号）成对包裹的值（[packages/client/ui-settings-models/src/client/apiKey.ts:35-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/apiKey.ts#L35-L39)）
- 判定顺序：空串放行、去空白后为空报空白失败、环境行或引号包裹或含非法字符报格式失败（[packages/client/ui-settings-models/src/client/apiKey.ts:51-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/apiKey.ts#L51-L58)）

### packages/client/ui-settings-models/src/client/index.ts

插件的浏览器半边入口：声明注入、构建共享 store 与 wire、订阅推送失效，并把模型页与两个首启步骤注册进各自的槽。

- 通过 declaration merging 把 `settings.models` 登记为该插件拥有的文案命名空间（[packages/client/ui-settings-models/src/client/index.ts:35-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L35-L43)）
- `refreshIfLoaded` 在快照仍为 idle 时直接返回，未打开过的页面不会因后台失效而发起请求（[packages/client/ui-settings-models/src/client/index.ts:53-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L53-L56)）
- `inject` 列出该 fiber 依赖的八个服务，包含三个 Remote 子命名空间与两个设置服务（[packages/client/ui-settings-models/src/client/index.ts:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L63-L66)）
- 以 effect 注册中英两份文案词典（[packages/client/ui-settings-models/src/client/index.ts:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L75)）
- 把 credentials / llm / settings 三个 Remote 命名空间组成一份 wire，并用它与设置作用域描述构造页面 store（[packages/client/ui-settings-models/src/client/index.ts:77-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L77-L84)）
- 模型页与 DeepSeek 首启步骤两个注入面共享同一个 controller、同一个快照 store 与同一个绑定后的翻译函数（[packages/client/ui-settings-models/src/client/index.ts:86-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L86-L101)）
- 内测声明的确认状态绑定到独立的设置命名空间与解码函数，其持久与否由该作用域自身的存储模式决定（[packages/client/ui-settings-models/src/client/index.ts:104-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L104-L112)）
- 订阅 `settings/document-updated`、`credentials/reference-updated`、`llm/adapters-updated` 三个转发事件与本地 `connection/reset`，全部触发同一个刷新；释放时销毁 welcome store 并解除全部订阅（[packages/client/ui-settings-models/src/client/index.ts:119-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L119-L131)）
- 把模型页以 id `models`、order 10 注册进 `settings.section`，并同时声明两个子槽：keyed 的卡片扩展槽与 list 的 footer 槽（[packages/client/ui-settings-models/src/client/index.ts:133-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L133-L143)）
- 把内测声明步骤以 order -100、官方 DeepSeek 步骤以 order 0 注册进 `settings.onboarding`，从而固定两步的先后（[packages/client/ui-settings-models/src/client/index.ts:144-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/index.ts#L144-L155)）

### packages/client/ui-settings-models/src/client/locales.ts

模型设置页与首启对话框的中英文案词典，由 `index.ts` 注册进 `settings.models` 命名空间。

- 无运行期机制

### packages/client/ui-settings-models/src/client/schema-operations.ts

把设置 schema 服务收窄成一组普通回调，交给本包的 store 与 React 组件使用。

- 把 rehydrate / validate / nodeAtPath / getPath / hasPath / setPath / deletePath 七个方法逐个包成闭包，调用方拿不到服务对象本身（[packages/client/ui-settings-models/src/client/schema-operations.ts:16-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/schema-operations.ts#L16-L25)）

### packages/client/ui-settings-models/src/client/slot-contract.ts

模型页两个扩展槽的类型声明文件，供仓库外插件在注册时引用。

- 无运行期机制

### packages/client/ui-settings-models/src/client/store.ts

模型设置页的浏览器端数据控制器，把可配置提供方目录、设置命名空间视图与凭据描述合成一份快照，供该页渲染以及首次运行引导步骤读取。

- `PROBE_ROUTE` 取一个含 NUL 字符、不会与真实路由重名的键，用于走字典 schema 到 profile 节点（[packages/client/ui-settings-models/src/client/store.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L22)）
- `joinProviderDirectory` 先按声明顺序输出已声明的可配置提供方，`active` 由已注册路由集合判定（[packages/client/ui-settings-models/src/client/store.ts:53-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L53-L62)）
- 再把没有声明的已注册路由追加为 `settingsNs` 为空、`settingsPath` 为空、`active` 为真的行（[packages/client/ui-settings-models/src/client/store.ts:63-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L63-L72)）
- `messageOf` 对非 `Error` 的拒绝值改用 `String()` 取文本（[packages/client/ui-settings-models/src/client/store.ts:131-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L131-L133)）
- `deriveKeyRef` 把路由 id 大写并将非字母数字段替换为 `_`，拼出 `<ROUTE>_API_KEY` 的凭据引用名（[packages/client/ui-settings-models/src/client/store.ts:142-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L142-L144)）
- `protocolChoices` 读命名空间 schema 的 `providers/<probe>/api` 节点，仅当它是 union 时返回其中的字符串取值作为可选协议（[packages/client/ui-settings-models/src/client/store.ts:155-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L155-L164)）
- `apiKeyEnvOf` 从解析后的 profile 取 `apiKeyEnv`，只有非空字符串才算命名了凭据引用（[packages/client/ui-settings-models/src/client/store.ts:167-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L167-L177)）
- 快照 store 以 `status: 'idle'`、空行、空命名空间表、`writable: false` 初始化（[packages/client/ui-settings-models/src/client/store.ts:182-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L182-L184)）
- `generation` 计数使旧响应在返回时被丢弃，只有最新一次 `load` 能写快照（[packages/client/ui-settings-models/src/client/store.ts:208-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L208-L209)）
- `load` 并行发起 `listProviders`、`listConfigurableProviders` 与 describe 面的 `ensure()`（[packages/client/ui-settings-models/src/client/store.ts:214-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L214-L218)）
- 任一提供方调用返回 `ok: false` 即抛出其 `error.message`（[packages/client/ui-settings-models/src/client/store.ts:219-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L219-L220)）
- 镜像视图缺失时抛错，文本取镜像自带的错误，没有则用固定的不可用文案（[packages/client/ui-settings-models/src/client/store.ts:221-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L221-L224)）
- 加载失败且仍是当前代次时把状态置为 `error` 并写入错误文本，直接返回不再继续（[packages/client/ui-settings-models/src/client/store.ts:228-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L228-L235)）
- 每行的 `configured` 由命名空间存在且（路径为空或该路径能解析出值）决定（[packages/client/ui-settings-models/src/client/store.ts:239-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L239-L240)）
- 每行的 `removable` 要求用户层有该路径且基础层没有该路径（[packages/client/ui-settings-models/src/client/store.ts:241-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L241-L244)）
- 把每行的 `apiKeyEnv` 或其派生引用名去重后，一次批量 `credentials.describe`（[packages/client/ui-settings-models/src/client/store.ts:253-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L253-L259)）
- 凭据调用的业务拒绝与传输异常都只记入 `credentialError`，不使整次加载失败（[packages/client/ui-settings-models/src/client/store.ts:260-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L260-L267)）
- 提交快照时按行填 `credential`（profile 命名了引用）或 `derivedCredential`（未命名引用时用派生名），二者互斥（[packages/client/ui-settings-models/src/client/store.ts:269-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L269-L284)）
- `providerUsable`：未注册即不可用；未命名凭据引用即视为可用；否则要求该凭据 `configured` 为真（[packages/client/ui-settings-models/src/client/store.ts:298-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L298-L302)）
- `onboardingReadiness` 在 idle/loading 且无行时返回 `loading`，`error` 状态返回 `unavailable`/`load-failed`（[packages/client/ui-settings-models/src/client/store.ts:331-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L331-L339)）
- 只要任一行 `providerUsable` 就返回 `provider-ready`，引导步骤到此结束（[packages/client/ui-settings-models/src/client/store.ts:340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L340)）
- 否则按 `provider === 'deepseek-official'`、`settingsNs === 'llm-deepseek'`、路径为空三个条件定位那一行，找不到即 `adapter-absent`（[packages/client/ui-settings-models/src/client/store.ts:341-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L341-L345)）
- 该行未注册返回 `provider-inactive`；凭据出错或凭据未描述返回 `credentials-unavailable`（[packages/client/ui-settings-models/src/client/store.ts:346-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L346-L359)）
- 设置不可写返回 `settings-read-only`，凭据不可写返回 `credential-read-only`，都通过则返回 `credential-missing`（[packages/client/ui-settings-models/src/client/store.ts:360-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/store.ts#L360-L372)）

### packages/client/ui-settings-models/src/client/welcome-store.ts

欢迎提示的状态控制器，跟随欢迎设置 scope，决定该提示是否已被确认以及确认写到哪里。

- `decodeWelcomeSection` 只接受非数组对象，其余值（含畸形持久值）一律解码为空段落（[packages/client/ui-settings-models/src/client/welcome-store.ts:31-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L31-L35)）
- `assertNever` 对未知的 scope 状态直接抛出（[packages/client/ui-settings-models/src/client/welcome-store.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L38-L40)）
- 状态源以 `status: 'idle'`、`acknowledged: false` 初始化（[packages/client/ui-settings-models/src/client/welcome-store.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L45-L47)）
- `load` 用 `??=` 保证只订阅一次 scope，随后立刻推导一次并返回已完成的 Promise（[packages/client/ui-settings-models/src/client/welcome-store.ts:63-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L63-L67)）
- `acknowledge` 在 scope 处于 `memory` 模式时只置进程内标志并返回 true，不发生写入（[packages/client/ui-settings-models/src/client/welcome-store.ts:76-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L76-L80)）
- 非 memory 模式下置 `saving` 屏蔽推导，向 scope 写入确认字段与版本号，`finally` 中解除屏蔽（[packages/client/ui-settings-models/src/client/welcome-store.ts:81-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L81-L87)）
- 写后重新推导并以推导结果判定成败，未落库时把状态置为 `error` 并给出未持久化的错误文本，返回值即该判定（[packages/client/ui-settings-models/src/client/welcome-store.ts:88-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L88-L96)）
- `dispose` 调用并清空订阅取消函数，停止跟随 scope（[packages/client/ui-settings-models/src/client/welcome-store.ts:100-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L100-L103)）
- `derive` 在保存过程中直接返回，不让中途的 scope 通知覆盖 `saving` 状态（[packages/client/ui-settings-models/src/client/welcome-store.ts:106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L106)）
- memory 模式下发布 `ready` 并以进程内标志作为 `acknowledged`（[packages/client/ui-settings-models/src/client/welcome-store.ts:108-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L108-L115)）
- scope 为 `loading` 时发布 `loading` 并清错；为 `unavailable` 时发布 `error`、把 `acknowledged` 复位为 false（[packages/client/ui-settings-models/src/client/welcome-store.ts:117-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L117-L126)）
- scope 为 `ready` 时以确认字段与版本号的严格相等判定 `acknowledged`（[packages/client/ui-settings-models/src/client/welcome-store.ts:127-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L127-L135)）
- 其余状态落到 `assertNever` 抛错（[packages/client/ui-settings-models/src/client/welcome-store.ts:136-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/client/welcome-store.ts#L136-L137)）

### packages/client/ui-settings-models/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-settings-models/src/index.ts

该包的 Host 侧加载入口，浏览器实现由 `./client` 导出。

- 无运行期机制

### packages/client/ui-settings-models/src/invariant.ts

该包的不变量伴生插件模块，向不变量服务登记包名。

- 声明 `inject = ['invariants']`，使该伴生插件在不变量服务就绪后才执行（[packages/client/ui-settings-models/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/invariant.ts#L13-L15)）
- `apply` 用空安装器登记包名并返回该注册的 disposer（[packages/client/ui-settings-models/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/invariant.ts#L22-L30)）

### packages/client/ui-settings-models/src/onboarding-copy.ts

欢迎提示确认所用的持久化坐标与版本号常量，被 `welcome-store.ts` 读取。

- 固定确认信息所在的设置命名空间名 `ui-onboarding`（[packages/client/ui-settings-models/src/onboarding-copy.ts:2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/onboarding-copy.ts#L2)）
- 固定存放已确认版本的字段名 `welcomeNoticeVersion`（[packages/client/ui-settings-models/src/onboarding-copy.ts:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/onboarding-copy.ts#L5)）
- 版本号常量按严格相等参与确认判定，改动该值会使已确认状态失效（[packages/client/ui-settings-models/src/onboarding-copy.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/src/onboarding-copy.ts#L11)）

### packages/client/ui-settings-models/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、声明输出目录与工程引用。

- 无运行期机制

### packages/client/ui-settings-models/tsdown.config.ts

该包的打包配置，决定发布产物里存在哪些运行时入口。

- 以包名与 `lib/types/index.js`、`lib/types/invariant.js` 两个入口调用共享的客户端打包配置，产出对应的运行时 bundle（[packages/client/ui-settings-models/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-models/tsdown.config.ts#L1-L3)）
