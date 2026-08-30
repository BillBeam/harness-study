---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/include
---

# vendor/include

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 4 个文件、43 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/include/README.md

该包的说明文档，给出挂载文件型条目子树的用法、示例配置文件与配置字段表。

- 无运行期机制

### vendor/include/package.json

该包的发布清单，供包管理器与运行期模块解析读取。

- `exports` 把包名解析到 `lib/index.js`，`main`/`types` 给出同一入口（[vendor/include/package.json:14-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/package.json#L14-L23)）
- `files` 限定发布进包的内容为 `lib/index.js`、类型声明与 `src`（[vendor/include/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/package.json#L24-L29)）

### vendor/include/src/index.ts

以 YAML/JSON 文件为后端的条目子树实现：读文件、打补丁、事务式更新子条目，并在可写时把变更写回文件。

- 定义 `!!js` 标量的 YAML 类型：读时构造成表达式节点对象，写时还原成原字符串（[vendor/include/src/index.ts:9-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L9-L15)）
- 导出由 JSON schema 扩展该表达式类型得到的条目列表方言，读写都用它（[vendor/include/src/index.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L23-L25)）
- 扩展名到 MIME 的映射决定支持的文件类型与解析分支（[vendor/include/src/index.ts:27-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L27-L33)）
- 写入重试上限、退避基数与可重试错误码集合（`EACCES`/`EBUSY`/`EPERM`）（[vendor/include/src/index.ts:35-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L35-L41)）
- 打补丁前对输入做结构化克隆，结果始终与输入脱离（[vendor/include/src/index.ts:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L63)）
- 无补丁时直接返回克隆（[vendor/include/src/index.ts:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L64)）
- 递归索引所有带 id 的条目，包括 group 条目 `config` 数组里的子条目（[vendor/include/src/index.ts:66-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L66-L75)）
- 带 id 的插入补丁在目标不存在或目标不是 group 时告警跳过，否则追加进该 group 的 `config`（[vendor/include/src/index.ts:80-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L80-L92)）
- 不带 id 的插入补丁追加到顶层条目列表（[vendor/include/src/index.ts:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L93-L95)）
- 插入的条目立即被索引，使同一补丁列表中靠后的补丁能命中它（[vendor/include/src/index.ts:96-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L96-L102)）
- 非插入补丁缺少 id 时告警跳过（[vendor/include/src/index.ts:105-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L105-L108)）
- 补丁 id 未命中任何条目时告警跳过（[vendor/include/src/index.ts:110-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L110-L114)）
- 补丁给出的 `name` 与目标不一致时告警跳过（[vendor/include/src/index.ts:116-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L116-L119)）
- 其余键逐一覆盖到目标条目，`id` 不被覆盖（[vendor/include/src/index.ts:121-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L121-L124)）
- 配置文件错误带 `read`/`parse`/`validate` 阶段标记与原因链（[vendor/include/src/index.ts:137-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L137-L142)）
- 该类带 group 标记符号，使加载器对它的配置保持字面而不做表达式插值（[vendor/include/src/index.ts:176-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L176-L182)）
- 日志开关按自身配置、父树设置、false 的顺序取值（[vendor/include/src/index.ts:196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L196)）
- 文件名由 `path` 相对 `ctx.baseUrl` 解析（[vendor/include/src/index.ts:197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L197)）
- 不受支持的扩展名在构造阶段抛错（[vendor/include/src/index.ts:198-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L198-L201)）
- 把子树的 `ctx.baseUrl` 改成该配置文件所在目录，子条目的相对模块名据此解析（[vendor/include/src/index.ts:204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L204)）
- 监听自身配置更新：`path` 未变时用新补丁重算当前数据并事务式更新子树，`path` 变了则交回默认更新链（[vendor/include/src/index.ts:206-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L206-L213)）
- `enqueue` 把每次子树变更串行排在前一次之后，前驱失败不阻断后继（[vendor/include/src/index.ts:225-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L225-L229)）
- `checkAccess` 用写权限探测把子树标记为只读（[vendor/include/src/index.ts:231-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L231-L238)）
- 读文件失败抛 `read` 阶段错误（[vendor/include/src/index.ts:242-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L242-L245)）
- 非强制读且内容与上次一致时返回空，不触发任何更新（[vendor/include/src/index.ts:247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L247)）
- 按类型分别用 YAML 方言、`JSON.parse` 或动态 import 解析，失败抛 `parse` 阶段错误（[vendor/include/src/index.ts:248-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L248-L260)）
- 顶层不是数组时抛 `validate` 阶段错误（[vendor/include/src/index.ts:261-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L261-L263)）
- 打补丁时把跳过告警接到加载器日志器（[vendor/include/src/index.ts:267-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L267-L271)）
- 初始化时强制读一次；文件不存在且配置了 initial 则先写出初始条目列表再重读，没有 initial 则抛错（[vendor/include/src/index.ts:273-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L273-L285)）
- 初始化让出停机 disposer 后才应用首份配置（[vendor/include/src/index.ts:287-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L287-L288)）
- 停机先停子条目组，再把挂起的写入落盘（[vendor/include/src/index.ts:291-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L291-L294)）
- `refresh` 在串行队列内重读，内容未变直接返回，否则应用新内容（[vendor/include/src/index.ts:301-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L301-L309)）
- 应用流程：打补丁 → 事务更新子条目组 → 记下内容与原始数据 → 复查写权限（[vendor/include/src/index.ts:315-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L315-L321)）
- 只读子树的写入直接抛错（[vendor/include/src/index.ts:323-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L323-L326)）
- 按类型用 YAML 方言 dump 或两空格缩进的 JSON 序列化（[vendor/include/src/index.ts:327-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L327-L331)）
- 先写 `.tmp` 再改名落位，改名遇可重试错误按递增延迟重试到上限（[vendor/include/src/index.ts:332-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L332-L341)）
- `writeFile` 只记下待写内容并安排一次 0 毫秒后的冲刷，连续调用相互合并（[vendor/include/src/index.ts:344-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L344-L350)）
- 冲刷把实际写入串到写队列尾部，前驱成败都继续，失败只打两条 warn（[vendor/include/src/index.ts:352-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L352-L368)）
- `write()` 发出 `loader/config-update` 事件并按当前根条目数据调度写盘（[vendor/include/src/index.ts:370-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L370-L374)）

### vendor/include/tsconfig.json

该包的 TypeScript 编译配置，只在构建与类型检查时使用。

- 无运行期机制
