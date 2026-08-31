---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/shell-env
---

# packages/shell/shell-env

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、22 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/shell-env/README.md

这个包的说明文档，介绍受管 `DSH_*` 环境的内容、扩展写法与配置字段。

- 无运行期机制

### packages/shell/shell-env/package.json

这个包的清单，声明入口映射、发布内容与依赖，被 Node 解析和打包时读取。

- `exports` 把包名映射到 `lib/index.js`，另外开放 `./invariant`、`./src/*` 和 `./package.json` 三个子路径（[packages/shell/shell-env/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/package.json#L16-L27)）
- `files` 限定发布物只包含 `lib/index.js`、`lib/invariant.js` 和 `lib/types` 下的声明文件（[packages/shell/shell-env/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/package.json#L28-L32)）
- `dependencies` 把校验库列为运行期真实依赖，与仅作对等声明的其余包区分（[packages/shell/shell-env/package.json:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/package.json#L42-L44)）

### packages/shell/shell-env/src/index.ts

包入口，实现 `ctx.shellEnv` 注册表，为每次模型 shell 调用生成受管的 `DSH_*` 环境快照。

- 以函数插件形式导出插件名与空的 `inject` 列表，不依赖任何服务即可加载（[packages/shell/shell-env/src/index.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L25-L26)）
- 配置模式只接受一个 `dshHome` 字符串字段（[packages/shell/shell-env/src/index.ts:35-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L35-L37)）
- 三个内建键被列为保留键，另有一条要求「大写字母开头、只含大写字母数字下划线」的键名正则（[packages/shell/shell-env/src/index.ts:71-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L71-L79)）
- 构造时以 `shellEnv` 名注册服务，并解析出家目录的绝对路径（[packages/shell/shell-env/src/index.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L99-L102)）
- `register` 在 `ctx.effect` 里完成注册，使贡献者随注册插件的纤程一起卸载（[packages/shell/shell-env/src/index.ts:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L111)）
- 贡献者名为空或重名时抛错（[packages/shell/shell-env/src/index.ts:112-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L112-L117)）
- 逐个校验声明键：前缀或后缀不合规、占用保留键、描述为空、键已被他人拥有，四种情况都在注册时抛错（[packages/shell/shell-env/src/index.ts:119-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L119-L135)）
- 校验通过后写入贡献者表和键归属表，卸载器把两张表里的对应条目删掉（[packages/shell/shell-env/src/index.ts:137-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L137-L142)）
- `collect` 先放入内建的家目录与 `DSH_SHELL=1`（[packages/shell/shell-env/src/index.ts:152-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L152-L156)）
- 只有执行带 agent 时才写入会话 id（[packages/shell/shell-env/src/index.ts:157-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L157-L159)）
- 贡献者按名字排序后依次调用其 `resolve`，返回未声明的键或非字符串值都抛错，其余写入快照（[packages/shell/shell-env/src/index.ts:161-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L161-L173)）
- 最终快照按键名排序并冻结后返回（[packages/shell/shell-env/src/index.ts:175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L175)）
- `list` 只列举插件贡献的键声明并按键名排序，不执行任何解析器，也不含内建键（[packages/shell/shell-env/src/index.ts:184-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L184-L192)）
- `apply` 构造注册表并自带注册一个持久化贡献者（[packages/shell/shell-env/src/index.ts:201-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L201-L205)）
- 该贡献者在无 agent 时返回空，有 agent 时通过 `ctx.get('sessionPersistence')?.locate(...)` 取位置，仅当类型为 `jsonl` 才输出会话文件路径（[packages/shell/shell-env/src/index.ts:210-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/index.ts#L210-L215)）

### packages/shell/shell-env/src/invariant.ts

这个包的不变量伴随插件，由不变量服务在装载时调用。

- `inject` 要求 `invariants` 服务先就位，插件才会应用（[packages/shell/shell-env/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/invariant.ts#L15)）
- `apply` 以包名向 `ctx.invariants` 注册一个空安装器，并返回其卸载器（[packages/shell/shell-env/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell-env/src/invariant.ts#L28-L29)）

### packages/shell/shell-env/tsconfig.json

这个包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
