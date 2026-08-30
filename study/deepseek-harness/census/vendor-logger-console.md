---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/logger-console
---

# vendor/logger-console

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、17 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/logger-console/README.md

该包的说明文档，给出挂载控制台日志导出器的用法与配置字段表。

- 无运行期机制

### vendor/logger-console/package.json

该包的发布清单，供包管理器与运行期模块解析读取。

- `exports` 按运行环境分流：Node 条件解析到 `lib/index.js`，其余环境解析到 `lib/browser.js`，类型统一指向共享声明（[vendor/logger-console/package.json:14-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/package.json#L14-L24)）
- `files` 限定发布进包的内容为两个入口、类型声明与 `src`（[vendor/logger-console/package.json:25-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/package.json#L25-L31)）

### vendor/logger-console/src/browser.ts

浏览器侧入口，覆写导出方法把日志直接交给原生 console。

- 按消息类型分派到 `console.error`/`console.warn`/`console.log`，前缀为类型首字母大写与日志器名，参数原样透传（[vendor/logger-console/src/browser.ts:8-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/browser.ts#L8-L15)）

### vendor/logger-console/src/index.ts

Node 侧入口，在共享实现之上补上对象格式化与终端颜色探测。

- 为 `%o`/`%O` 装上基于 `util.inspect` 的格式化器，深度无限、紧凑、不折行，颜色跟随导出器配置（[vendor/logger-console/src/index.ts:9-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/index.ts#L9-L18)）
- 默认颜色级别取标准输出的颜色支持等级，不支持时为 0（[vendor/logger-console/src/index.ts:20-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/index.ts#L20-L25)）

### vendor/logger-console/src/shared.ts

Node 与浏览器两个入口共用的控制台导出器：定义配置、注册到日志服务并把消息渲染成一行文本。

- 配置 schema 定义颜色级别、最大长度、按日志器名的级别表、时间差开关、时间戳模板与标签样式，并给出时间戳模板与时间差的默认值（[vendor/logger-console/src/shared.ts:31-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/shared.ts#L31-L42)）
- 构造时先铺默认值再用配置覆盖、记录起始时刻，并把自身注册为日志服务的导出器（[vendor/logger-console/src/shared.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/shared.ts#L54-L58)）
- 基类默认值为不着色、固定时间戳模板、不显示时间差（[vendor/logger-console/src/shared.ts:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/shared.ts#L60-L66)）
- 基类导出方法把渲染结果写到 `console.log`（[vendor/logger-console/src/shared.ts:68-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/shared.ts#L68-L71)）
- 渲染时按模板输出带颜色的时间戳并把它计入缩进宽度（[vendor/logger-console/src/shared.ts:73-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/shared.ts#L73-L80)）
- 日志器名按名字散列取色并加粗，按配置的宽度与对齐方向左补或右补空格，右对齐时前缀与标签互换位置并追加缩进（[vendor/logger-console/src/shared.ts:81-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/shared.ts#L81-L89)）
- 正文经格式化后，其中的换行按算出的缩进宽度补齐空格（[vendor/logger-console/src/shared.ts:90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/shared.ts#L90)）
- 开启时间差时在行尾追加与上一条消息的时间间隔，并把时间戳推进到本条消息（[vendor/logger-console/src/shared.ts:91-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/src/shared.ts#L91-L96)）

### vendor/logger-console/tsconfig.json

该包的 TypeScript 编译配置，只在构建与类型检查时使用。

- 无运行期机制

### vendor/logger-console/tsdown.config.ts

该包的打包配置，决定两个运行期入口文件的产出形态。

- 以 ESM/node/es2024 打包到 `lib`，关闭固定扩展名、类型产出与清理（[vendor/logger-console/tsdown.config.ts:11-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/tsdown.config.ts#L11-L19)）
- Node 入口与浏览器入口各走一次单入口打包，共享基类被分别内联进两个产物而不是拆成公共分块（[vendor/logger-console/tsdown.config.ts:21-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/logger-console/tsdown.config.ts#L21-L24)）
