---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/cosmokit
---

# vendor/cosmokit

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、52 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/cosmokit/README.md

被 vendor 化的通用工具库的说明文档，只给出安装与导入示例。

- 无运行期机制

### vendor/cosmokit/package.json

该工具库的包清单，声明入口与发布内容；上层框架包把它列为运行期依赖。

- `"type": "module"` 使包内 `.js` 按 ESM 解析（[vendor/cosmokit/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/package.json#L13)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[vendor/cosmokit/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/package.json#L14-L15)）
- `exports` 只放行根导出、`./src/*` 源码子路径与 `./package.json`，其余路径不可导入（[vendor/cosmokit/package.json:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/package.json#L16-L23)）
- `files` 限定发布内容为 `lib/index.js`、类型声明与 map、以及 `src`（[vendor/cosmokit/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/package.json#L24-L29)）

### vendor/cosmokit/src/array.ts

数组集合运算与归一化辅助函数，被框架内部与其它工具模块调用。

- `contain` 判断第二个数组的每一项是否都出现在第一个数组中（[vendor/cosmokit/src/array.ts:4-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/array.ts#L4-L6)）
- `intersection` 按第一个数组的顺序返回同时出现在两个数组中的项（[vendor/cosmokit/src/array.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/array.ts#L9-L11)）
- `difference` 返回只在第一个数组中出现的项（[vendor/cosmokit/src/array.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/array.ts#L14-L16)）
- `union` 用 Set 合并两个数组并保留首次出现顺序（[vendor/cosmokit/src/array.ts:19-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/array.ts#L19-L21)）
- `deduplicate` 用 Set 去重并保留首次出现顺序（[vendor/cosmokit/src/array.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/array.ts#L24-L26)）
- `remove` 就地 splice 掉首个匹配项并返回是否命中（[vendor/cosmokit/src/array.ts:29-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/array.ts#L29-L37)）
- `makeArray` 把数组原样返回、nullish 归一为空数组、其余包成单元素数组（[vendor/cosmokit/src/array.ts:40-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/array.ts#L40-L42)）

### vendor/cosmokit/src/index.ts

该工具库的根入口，把各源码模块整体再导出。

- 无运行期机制

### vendor/cosmokit/src/misc.ts

通用类型别名与对象操作函数，`defineProperty`、`isNullable` 等被框架核心大量使用。

- `noop` 是运行期返回 `undefined` 的空回调（[vendor/cosmokit/src/misc.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L17)）
- `isNullable` 只把 `null` 与 `undefined` 判为真并作为类型守卫（[vendor/cosmokit/src/misc.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L20-L22)）
- `isNonNullable` 取 `isNullable` 的反面并收窄类型（[vendor/cosmokit/src/misc.ts:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L25-L27)）
- `isPlainObject` 把非空、typeof 为 object 且非数组的值判为真（[vendor/cosmokit/src/misc.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L30-L32)）
- `filterKeys` 按谓词过滤自有可枚举条目并组回新对象（[vendor/cosmokit/src/misc.ts:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L39-L41)）
- `mapValues` 逐条变换值、保持键集不变，并以 `valueMap` 之名再导出（[vendor/cosmokit/src/misc.ts:44-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L44-L49)）
- `pick` 无键集时做浅拷贝，有键集时逐个取值，且默认跳过值为 `undefined` 的键、`forced` 时强行保留（[vendor/cosmokit/src/misc.ts:52-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L52-L59)）
- `omit` 在浅拷贝上删掉指定键（[vendor/cosmokit/src/misc.ts:62-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L62-L69)）
- `defineProperty` 定义可写、不可枚举的属性并返回原对象，框架用它挂 tracker 等内部元数据（[vendor/cosmokit/src/misc.ts:76-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/misc.ts#L76-L78)）

### vendor/cosmokit/src/string.ts

字符串大小写、命名风格与路径格式化函数；`hyphenate` 被日志服务用于推导 logger 名。

- `capitalize`/`uncapitalize` 改写首字符大小写（[vendor/cosmokit/src/string.ts:2-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/string.ts#L2-L9)）
- `camelCase` 把 `-x`/`_x` 替换为大写字母（[vendor/cosmokit/src/string.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/string.ts#L12-L14)）
- `tokenize` 按字符码逐字符走 DELIM/UPPER/LOWER 状态机，在大小写边界与分隔符处插入指定分隔符并把大写降为小写（[vendor/cosmokit/src/string.ts:22-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/string.ts#L22-L54)）
- `paramCase`/`snakeCase` 以 `-`、`_` 为输入分隔符，分别输出 `-` 与 `_` 连接的结果（[vendor/cosmokit/src/string.ts:57-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/string.ts#L57-L64)）
- `camelize` 与 `hyphenate` 在运行期分别是 `camelCase` 与 `paramCase` 的别名（[vendor/cosmokit/src/string.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/string.ts#L66-L69)）
- `formatProperty` 对符号键与非标识符键输出方括号形式（后者带 JSON 引号），标识符键输出点号形式（[vendor/cosmokit/src/string.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/string.ts#L99-L102)）
- `trimSlash` 去掉一个结尾斜杠，`sanitize` 补足开头斜杠后再去尾斜杠（[vendor/cosmokit/src/string.ts:105-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/string.ts#L105-L113)）

### vendor/cosmokit/src/time.ts

时间常量与时长/日期的解析、格式化函数，集中在 `Time` 命名空间下。

- 定义毫秒到周的时长常量，其它函数与调用方都以它们换算（[vendor/cosmokit/src/time.ts:3-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L3-L8)）
- 模块级保存一个时区偏移量（初值取自当前环境），并提供读写它的函数，改写后影响后续日期编号换算（[vendor/cosmokit/src/time.ts:10-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L10-L18)）
- `getDateNumber` 把时间戳或 Date 按偏移量折算成整数日期编号，`fromDateNumber` 反向还原成 Date（[vendor/cosmokit/src/time.ts:20-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L20-L30)）
- 由周/日/时/分/秒五段可选单位拼出整串匹配的时长正则（[vendor/cosmokit/src/time.ts:32-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L32-L39)）
- `parseTime` 不匹配时返回 0，匹配则把五段数值分别乘以对应常量求和（[vendor/cosmokit/src/time.ts:41-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L41-L49)）
- `parseDate` 先按时长解析并相对当前时间偏移，否则对纯时刻补当天日期、对短日期补当前年份，空串回落到当前时间（[vendor/cosmokit/src/time.ts:51-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L51-L61)）
- `format` 按绝对值落在天/时/分/秒的哪一档四舍五入并加单位后缀，不足一秒时输出毫秒（[vendor/cosmokit/src/time.ts:63-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L63-L75)）
- `toDigits` 左侧补零到指定长度（[vendor/cosmokit/src/time.ts:77-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L77-L79)）
- `template` 依次把 `yyyy/yy/MM/dd/hh/mm/ss/SSS` 各替换一次为对应的本地时间字段（[vendor/cosmokit/src/time.ts:81-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/time.ts#L81-L91)）

### vendor/cosmokit/src/types.ts

运行期类型判定、二进制编解码、深拷贝与深比较函数。

- `is` 单参时返回柯里化谓词；双参时先试全局构造器的 `instanceof`，再回落到 `Object.prototype.toString` 的标签比较（[vendor/cosmokit/src/types.ts:12-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L12-L16)）
- `isArrayBufferLike` 把 `ArrayBuffer` 与 `SharedArrayBuffer` 都判为真，`isArrayBufferSource` 再并上 `ArrayBuffer.isView`（[vendor/cosmokit/src/types.ts:18-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L18-L24)）
- `Binary.fromSource` 对视图按 byteOffset/byteLength 切出独立缓冲，对缓冲本身原样返回（[vendor/cosmokit/src/types.ts:33-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L33-L40)）
- `toBase64` 在有 `Buffer` 时走 Buffer，否则逐字节拼字符串后 `btoa`（[vendor/cosmokit/src/types.ts:42-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L42-L53)）
- `fromBase64` 在有 `Buffer` 时走 Buffer，否则用 `atob` 逐字符取码构造 Uint8Array（[vendor/cosmokit/src/types.ts:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L55-L58)）
- `toHex` 在有 `Buffer` 时走 Buffer，否则逐字节转两位十六进制拼接（[vendor/cosmokit/src/types.ts:60-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L60-L64)）
- `fromHex` 在有 `Buffer` 时走 Buffer，否则先丢弃奇数长度的最后一个字符再两两解析（[vendor/cosmokit/src/types.ts:66-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L66-L74)）
- 四个顶层常量把 Binary 的编解码函数再导出为 base64/hex 转换别名（[vendor/cosmokit/src/types.ts:78-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L78-L84)）
- `clone` 对原始值直接返回，对 Date、RegExp、缓冲与视图各按类型复制（[vendor/cosmokit/src/types.ts:89-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L89-L94)）
- `clone` 用引用表处理循环引用，数组先登记再逐项递归（[vendor/cosmokit/src/types.ts:95-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L95-L104)）
- `clone` 对普通对象保留原型，并按自有键（含符号键）连描述符复制、其中数据属性的值递归克隆（[vendor/cosmokit/src/types.ts:105-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L105-L114)）
- `deepEqual` 先做同一性判断，非严格模式下两侧都 nullish 即相等，类型不同或非对象则不等（[vendor/cosmokit/src/types.ts:118-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L118-L123)）
- `deepEqual` 依次按数组、Date、RegExp、二进制缓冲分派专门比较（一侧命中而另一侧不命中即判不等），都不命中时并集键逐个递归比较（[vendor/cosmokit/src/types.ts:125-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cosmokit/src/types.ts#L125-L142)）

### vendor/cosmokit/tsconfig.json

该包的 TypeScript 编译配置，指定源码目录、声明输出目录与放宽的检查项。

- 无运行期机制
