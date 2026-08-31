---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/schemastery
---

# vendor/schemastery

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、59 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/schemastery/README.md

被 vendor 的 schema 校验库的说明文档，逐条列举各 schema 构造器、实例方法、校验选项与序列化用法。

- 无运行期机制

### vendor/schemastery/package.json

该 vendor 包的清单，声明入口、导出映射与随包发布的文件集。

- `main`/`module`/`types` 指向 `lib/index.cjs`、`lib/index.mjs`、`lib/types/index.d.ts`（[vendor/schemastery/package.json:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/package.json#L14-L16)）
- `exports` 把 `.` 按 types/import/require 三分支解析，并额外暴露 `./src/*` 与 `./package.json`（[vendor/schemastery/package.json:17-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/package.json#L17-L25)）
- `files` 限定发布内容为两份 bundle、类型声明与 `src`（[vendor/schemastery/package.json:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/package.json#L26-L32)）
- 运行期依赖声明为 `@standard-schema/spec` 与工作区内的 `@deepseek-ai/cosmokit`（[vendor/schemastery/package.json:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/package.json#L35-L38)）

### vendor/schemastery/src/index.ts

schema 校验库的全部实现：可调用的 schema 对象、校验解析器注册表、各内置类型的解析逻辑与序列化。

- 在 `globalThis` 上初始化自增序号 `__schemastery_index__` 与序列化引用表 `__schemastery_refs__`（[vendor/schemastery/src/index.ts:207-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L207-L208)）
- `ValidationError` 构造时把 `options.path` 拼成 `$.a[0]` 形式的前缀并加到消息前（[vendor/schemastery/src/index.ts:210-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L210-L226)）
- `ValidationError.is` 通过原型上定义的符号属性识别跨实例的校验错误（[vendor/schemastery/src/index.ts:228-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L228-L235)）
- `Schema()` 返回的是一个函数：调用它即以自身为 schema 执行 `Schema.resolve` 并取第一个返回值（[vendor/schemastery/src/index.ts:239-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L239-L242)）
- 传入带 `refs` 的对象时重建整张引用图（`sKey`/`inner`/`list`/`dict` 逐个换成引用实例）并返回 `uid` 对应的节点（[vendor/schemastery/src/index.ts:244-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L244-L255)）
- 反序列化时字符串形式的 `callback` 用 `new Function` 编译回函数，失败则静默保留原值（[vendor/schemastery/src/index.ts:258-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L258-L263)）
- 每个 schema 从全局计数器取一个不可写的 `uid`，并把原型设为 `Schema.prototype`、`meta` 兜底为空对象（[vendor/schemastery/src/index.ts:264-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L264-L268)）
- `~standard` getter 暴露 Standard Schema 的 `validate`，把校验错误转成 `{ issues: [{ message, path }] }`，非校验错误继续抛出（[vendor/schemastery/src/index.ts:275-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L275-L292)）
- `toJSON` 用全局引用表把共享与递归节点压平成 `{ uid, refs }`，嵌套调用时只回填 `uid`（[vendor/schemastery/src/index.ts:296-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L296-L307)）
- `set`/`push` 就地改写 `dict` 条目与 `list` 成员并返回自身（[vendor/schemastery/src/index.ts:309-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L309-L317)）
- `i18n` 复制 schema 后按 `dict`/`list`/`inner`/`sKey` 递归下发消息，并把 `$description`/`$desc` 或字符串合并进 `meta.description`（[vendor/schemastery/src/index.ts:319-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L319-L368)）
- `extra` 复制 schema 并写入任意 `meta` 键（[vendor/schemastery/src/index.ts:370-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L370-L374)）
- 批量生成 `required`/`disabled`/`collapse`/`hidden`/`loose` 五个方法，默认写入 `true`（[vendor/schemastery/src/index.ts:376-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L376-L384)）
- `deprecated`/`experimental` 向 `meta.badges` 追加带类型的徽标（[vendor/schemastery/src/index.ts:386-398](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L386-L398)）
- `pattern` 把 `RegExp` 拆成 `source`/`flags` 存进 `meta`，供字符串解析器重建（[vendor/schemastery/src/index.ts:400-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L400-L405)）
- `simplify` 按类型递归剔除与默认值相等的部分：对象/字典逐键收缩、数组/元组逐项收缩、交集合并、联合取第一个能校验通过的分支（[vendor/schemastery/src/index.ts:407-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L407-L442)）
- `toString` 按 `type` 派发到格式化表，缺失时退化成 `Schema<type>`（[vendor/schemastery/src/index.ts:444-446](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L444-L446)）
- `role` 与批量生成的 `default`/`link`/`comment`/`description`/`max`/`min`/`step` 都返回写入 `meta` 的副本（[vendor/schemastery/src/index.ts:448-462](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L448-L462)）
- `Schema.extend` 把解析函数按类型名写入 `resolvers` 注册表（[vendor/schemastery/src/index.ts:464-468](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L464-L468)）
- `Schema.resolve` 先让 `options.ignore` 短路，再对空值走 `required` 报错或沿 `intersect` 链向下找默认值并 `clone`（[vendor/schemastery/src/index.ts:470-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L470-L484)）
- 未注册的类型抛 `unsupported type`；解析抛错时若 `meta.loose` 为真则吞掉并返回默认值（[vendor/schemastery/src/index.ts:486-495](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L486-L495)）
- `Schema.from` 把空值、原始值、已有 schema、`String`/`Number`/`Boolean`/`Function` 及任意构造器分别映射成对应 schema（[vendor/schemastery/src/index.ts:497-515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L497-L515)）
- `Schema.lazy` 延迟到 `toJSON` 或解析时才调用 builder，并把外层 `meta` 合并进生成的内层 schema（[vendor/schemastery/src/index.ts:517-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L517-L527)）
- `natural`/`percent` 以步长与上下界组合出受限数字，后者附加 `slider` 角色（[vendor/schemastery/src/index.ts:529-535](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L529-L535)）
- `date` 用联合加 transform 接受 `Date` 或把字符串解析成 `Date`，`NaN` 时抛校验错误（[vendor/schemastery/src/index.ts:537-546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L537-L546)）
- `regExp` 接受 `RegExp` 或按指定 flag 编译字符串，编译失败转成校验错误（[vendor/schemastery/src/index.ts:548-559](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L548-L559)）
- `arrayBuffer` 接受 `ArrayBuffer`/`SharedArrayBuffer`/二进制源，并在指定编码时额外接受 hex 或 base64 字符串（[vendor/schemastery/src/index.ts:561-579](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L561-L579)）
- `lazy` 解析器在首次校验时展开 builder 结果再递归解析（[vendor/schemastery/src/index.ts:581-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L581-L587)）
- `any` 原样放行、`never` 一律抛错、`const` 用深比较判等（[vendor/schemastery/src/index.ts:589-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L589-L600)）
- `checkWithinRange` 依据 `meta.max`/`meta.min` 抛出带描述词的越界错误，可跳过下界检查（[vendor/schemastery/src/index.ts:602-606](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L602-L606)）
- `string` 解析器校验类型、按 `meta.pattern` 重建正则匹配、再按长度检查范围（[vendor/schemastery/src/index.ts:608-616](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L608-L616)）
- `decimalShift`/`isMultipleOf` 以整数化移位判断小数步长的整除关系（[vendor/schemastery/src/index.ts:618-637](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L618-L637)）
- `number` 解析器校验类型、范围与步长整除（[vendor/schemastery/src/index.ts:639-647](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L639-L647)）
- `boolean` 解析器只接受布尔值（[vendor/schemastery/src/index.ts:649-652](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L649-L652)）
- `bitset` 解析器在数字与字符串数组之间双向换算，数字入参反解出键名，未知键被忽略，等于默认值时不返回适配值（[vendor/schemastery/src/index.ts:654-674](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L654-L674)）
- `function` 解析器只接受函数（[vendor/schemastery/src/index.ts:676-679](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L676-L679)）
- `is` 解析器对函数用 `instanceof`，对字符串沿原型链比对 `constructor.name`（[vendor/schemastery/src/index.ts:681-696](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L681-L696)）
- `property` 把子路径追加进错误 path、把适配值写回源对象；`autofix` 打开时删除非法键并回退到默认值（[vendor/schemastery/src/index.ts:698-711](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L698-L711)）
- `array` 解析器校验数组类型、按元素默认值决定是否跳过长度下界、逐项解析（[vendor/schemastery/src/index.ts:713-717](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L713-L717)）
- `dict` 解析器先用 `sKey` 解析并可能改写键名（严格模式下跳过不合法键，否则抛错），再逐值解析并同步删除旧键（[vendor/schemastery/src/index.ts:719-735](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L719-L735)）
- `tuple` 解析器按位解析，非严格模式把超出长度的尾部原样追加（[vendor/schemastery/src/index.ts:737-743](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L737-L743)）
- `object` 解析器只保留有值或源对象里存在的键，非严格模式把未声明的键并回结果（[vendor/schemastery/src/index.ts:745-763](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L745-L763)）
- `union` 解析器按顺序取第一个成功的分支，全部失败时抛出带类型字符串与输入 JSON 的错误（[vendor/schemastery/src/index.ts:765-775](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L765-L775)）
- `intersect` 解析器以严格模式逐个解析并合并对象结果，类型不一致或标量冲突时抛错，非严格模式再并回原对象多余键（[vendor/schemastery/src/index.ts:777-795](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L777-L795)）
- `transform` 解析器先严格解析内层再过回调，`preserve` 决定是否同时产出写回源的适配值（[vendor/schemastery/src/index.ts:797-813](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L797-L813)）
- `defineMethod` 同时注册格式化函数与静态工厂：按 keys 依次填 `sKey`/`inner`/`list`/`dict`/`bits`/`callback`/`constructor`，并给 callback 与构造器挂上 `toJSON`（[vendor/schemastery/src/index.ts:818-851](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L818-L851)）
- 工厂按类型名预置默认值：对象/字典为 `{}`、数组/元组为 `[]`、bitset 为 `0`（[vendor/schemastery/src/index.ts:852-861](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L852-L861)）
- 逐个定义 `is`/`any`/`never`/`const`/`string`/`number`/`boolean`/`bitset`/`function`/`array`/`dict`/`tuple` 的工厂与类型字符串（[vendor/schemastery/src/index.ts:864-882](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L864-L882)）
- `object`/`union`/`intersect`/`transform` 的格式化分别产出可选标记的字段列表、`|` 连接（内联时加括号）、`&` 连接与透传内层（[vendor/schemastery/src/index.ts:884-900](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L884-L900)）
- 模块默认导出 `Schema`（[vendor/schemastery/src/index.ts:902](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/src/index.ts#L902)）

### vendor/schemastery/tsconfig.json

该 vendor 包的 TypeScript 编译配置，指定源码与声明输出目录并放宽若干检查项。

- 无运行期机制

### vendor/schemastery/tsdown.config.ts

打包配置，决定该包最终产出的 bundle 入口、格式与文件扩展名。

- 以 `lib/types/index.js` 为入口、输出到 `lib`，同时产出 esm 与 cjs 两种格式（[vendor/schemastery/tsdown.config.ts:8-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/tsdown.config.ts#L8-L13)）
- `outExtensions` 把 esm 产物命名为 `.mjs`、cjs 产物命名为 `.cjs`，与清单里的 `main`/`module` 对应（[vendor/schemastery/tsdown.config.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/tsdown.config.ts#L14)）
- 关闭 `dts` 与 `clean`，保留 tsc 先前写入 `lib` 的类型声明（[vendor/schemastery/tsdown.config.ts:15-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/schemastery/tsdown.config.ts#L15-L16)）
