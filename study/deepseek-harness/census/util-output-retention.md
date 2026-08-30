---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/output-retention
---

# packages/util/output-retention

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、29 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/output-retention/README.md

该包的英文 README，说明两种保留器的用法、`truncated` 的含义边界以及各工具如何使用它们，供阅读者与文档站使用。

- 无运行期机制

### packages/util/output-retention/package.json

该包的 npm 清单，决定这个工具库以什么入口、什么子路径被其他包导入。

- `type: module` 与 `main`/`types` 把包按 ESM 从 `lib/index.js` 加载（[packages/util/output-retention/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/package.json#L13-L15)）
- `exports` 把根入口映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并额外开放 `./src/*` 与 `./package.json` 两个子路径（[packages/util/output-retention/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/util/output-retention/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/package.json#L28-L32)）

### packages/util/output-retention/src/index.ts

该包唯一的实现文件，提供按条目与按字节两种保留器以及省略措辞的拼装函数，被 glob、grep、bash、web_fetch、web_search 等工具用来裁剪返回给模型的内容。

- `assertBudget` 要求预算是非负整数，否则抛出带字段名的错误（[packages/util/output-retention/src/index.ts:130-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L130-L134)）
- `ItemRetainer` 构造时校验并记下 `maxItems`（[packages/util/output-retention/src/index.ts:153-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L153-L156)）
- `push` 每次递增 `seen`；未到上限时收下该条目并返回 `kept: true, truncated: false`（[packages/util/output-retention/src/index.ts:166-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L166-L173)）
- 到上限后丢弃该条目、累加省略计数并返回 `kept: false, truncated: true`，调用方继续推入以得到精确计数（[packages/util/output-retention/src/index.ts:174-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L174-L178)）
- `finish` 返回保留条目、`seen`、`kept`，并在有省略时给出 `exact` 计数、否则给出 `none`（[packages/util/output-retention/src/index.ts:186-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L186-L197)）
- 模块级 `TextEncoder`/`TextDecoder`，解码器为非 fatal，内部畸形字节转成替换字符（[packages/util/output-retention/src/index.ts:200-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L200-L201)）
- `trimTrailingPartialUtf8` 最多回退三个续字节找到前导字节，按前导字节声明的长度判断序列是否残缺，残缺则截掉（[packages/util/output-retention/src/index.ts:211-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L211-L222)）
- `trimLeadingContinuationUtf8` 丢掉开头的续字节，使后缀从前导或 ASCII 字节开始（[packages/util/output-retention/src/index.ts:228-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L228-L233)）
- `TextRetainer` 构造按 `head`/`tail`/`headTail` 三种策略分别校验预算并设定前缀容量与后缀容量（[packages/util/output-retention/src/index.ts:257-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L257-L276)）
- `push` 把字符串按 UTF-8 编码成字节，并累加总字节数（[packages/util/output-retention/src/index.ts:288-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L288-L290)）
- 前缀侧只吸收到容量剩余量为止，超出部分不进前缀（[packages/util/output-retention/src/index.ts:293-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L293-L298)）
- 后缀侧先整块追加，再循环丢掉已完全滑出窗口的头块（[packages/util/output-retention/src/index.ts:302-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L302-L310)）
- 头块仍超过窗口时用 `subarray` 切掉多余前导字节，使累加器内存保持在后缀容量以内（[packages/util/output-retention/src/index.ts:319-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L319-L323)）
- `push` 的返回值用 `omittedAt` 比较推入前后的省略量，得出本块是否有字节被丢弃与累计是否已截断（[packages/util/output-retention/src/index.ts:330-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L330-L334)）
- `omittedAt` 以总字节减去前缀可留量与后缀可留量算出省略字节数（[packages/util/output-retention/src/index.ts:338-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L338-L342)）
- `finish` 算出前后缀长度，拼接前缀块，并从后缀累加器尾部取出后缀切片（[packages/util/output-retention/src/index.ts:351-355](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L351-L355)）
- 无预算省略时把前后缀当作相邻片段整体解码，有省略时分别做 UTF-8 边界裁剪并各自解码后相连（[packages/util/output-retention/src/index.ts:364-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L364-L370)）
- 省略字节数按实际返回的字节量计算，把边界裁剪掉的残缺码点字节也计入（[packages/util/output-retention/src/index.ts:376-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L376-L385)）
- `concat` 按各块总长分配一块连续缓冲并顺序写入（[packages/util/output-retention/src/index.ts:390-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L390-L400)）
- `describeOmitted` 对 `none` 返回空串、对 `exact` 输出带数字的 `Omitted N <unit>.`、对 `unknown` 输出不带数字的句子（[packages/util/output-retention/src/index.ts:412-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L412-L421)）
- `formatRetentionNotice` 把省略子句与调用方给出的恢复建议过滤空段后以单个空格拼成一行页脚（[packages/util/output-retention/src/index.ts:436-443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/index.ts#L436-L443)）

### packages/util/output-retention/src/invariant.ts

该包的 invariant 伴生插件，被 invariants 服务加载以登记包所有权。

- 导出 `name` 与 `inject`，把伴生插件命名为 `output-retention-invariant` 并声明依赖 `invariants` 服务（[packages/util/output-retention/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/invariant.ts#L13-L15)）
- 安装函数为空体，不注册任何运行期检查（[packages/util/output-retention/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该安装函数并返回其 disposer（[packages/util/output-retention/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/output-retention/src/invariant.ts#L28-L29)）

### packages/util/output-retention/tsconfig.json

该包的 TypeScript 编译配置，规定源目录、声明输出目录与工程引用。

- 无运行期机制
