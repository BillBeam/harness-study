---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/experimental/webworker-packer
---

# packages/experimental/webworker-packer

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、81 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/experimental/webworker-packer/README.md

包 README，说明该打包器如何把一份组合好的配置与仓库构建产物压成浏览器工作线程挂载的文件系统镜像，以及三层规则栈与已知限制。

- 无运行期机制

### packages/experimental/webworker-packer/bin.js

提交进仓库的稳定 bin 链接目标，命令实际运行时转发到构建产物。

- 首行 shebang 使该文件可作为可执行命令被直接启动（[packages/experimental/webworker-packer/bin.js:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/bin.js#L1)）
- 相对自身 URL 定位 `./lib/bin.js`，若该构建产物不存在则向标准错误写出提示并以退出码 1 结束（[packages/experimental/webworker-packer/bin.js:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/bin.js#L15-L19)）
- 存在时以动态 import 加载并执行构建产物入口（[packages/experimental/webworker-packer/bin.js:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/bin.js#L20)）

### packages/experimental/webworker-packer/package.json

包清单，声明命令名、库入口、导出子路径、分发文件与依赖。

- `bin` 把命令名 `dsh-pack-vfs-image` 映射到仓库内的 `./bin.js`（[packages/experimental/webworker-packer/package.json:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/package.json#L14-L16)）
- `main`/`types` 与 `exports` 把 `.` 指向 `lib/index.js`、`./invariant` 指向 `lib/invariant.js`，并开放 `./src/*` 与 `./package.json` 原样子路径（[packages/experimental/webworker-packer/package.json:11-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/package.json#L11-L28)）
- `files` 把分发内容限定为三个 lib 入口、链接目标 `bin.js`、`lib/repository-*.js` 与类型声明（[packages/experimental/webworker-packer/package.json:29-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/package.json#L29-L36)）
- `dependencies` 声明打包运行时真正加载的 YAML 解析、glob 匹配、配置条目模式与工作线程运行时包（[packages/experimental/webworker-packer/package.json:38-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/package.json#L38-L44)）
- `private: true` 使该包不进入正式发布（[packages/experimental/webworker-packer/package.json:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/package.json#L5)）

### packages/experimental/webworker-packer/src/bin.ts

命令行入口：解析参数、调用库打出基础镜像与各个覆盖层归档，再写清单与报告。

- 首行 shebang 使编译产物可直接作为命令执行（[packages/experimental/webworker-packer/src/bin.ts:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L1)）
- `flag` 在 argv 中按 `--名字 值` 取参：缺失且无默认值时抛错，出现但后面没有值或紧跟另一个 `--` 开头的词时也抛错（[packages/experimental/webworker-packer/src/bin.ts:30-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L30-L41)）
- 仓库根目录由自身模块 URL 上溯四级推出（[packages/experimental/webworker-packer/src/bin.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L43)）
- `--profile` 缺省为 `web`，`--out` 必填，相对输出路径按当前工作目录解析（[packages/experimental/webworker-packer/src/bin.ts:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L44-L46)）
- 组装打包参数：组合出的配置、profile 名、`--root` 缺省 `/dsh`、工作区包索引、解析起点与配置树（[packages/experimental/webworker-packer/src/bin.ts:48-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L48-L55)）
- 只要有依赖没解析出来就抛错，不写出这份不完整镜像（[packages/experimental/webworker-packer/src/bin.ts:57-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L57-L59)）
- 递归建出输出目录后把镜像字节写入目标文件（[packages/experimental/webworker-packer/src/bin.ts:61-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L61-L62)）
- 逐个把预置样例的目录树打成 `fixtures/<id>.tar.gz` 覆盖层并写盘，同时收集一行体积报告（[packages/experimental/webworker-packer/src/bin.ts:64-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L64-L79)）
- 写出浏览器可读的样例清单，含版本号、默认样例（无样例时为 null）与每个样例的 id/标签/描述/覆盖层路径（[packages/experimental/webworker-packer/src/bin.ts:80-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L80-L88)）
- 把打包报告与样例行合并写到标准输出（[packages/experimental/webworker-packer/src/bin.ts:89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/bin.ts#L89)）

### packages/experimental/webworker-packer/src/index.ts

包的库入口，把三个实现模块的公开成员集中再导出。

- 无运行期机制

### packages/experimental/webworker-packer/src/invariant.ts

包自带的不变量伴生插件，向不变量注册表登记本包的归属。

- 安装器为空函数，不注册任何运行期检查（[packages/experimental/webworker-packer/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/invariant.ts#L22)）
- `apply` 把包名连同空安装器注册进 `ctx.invariants` 并返回注销函数（[packages/experimental/webworker-packer/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/invariant.ts#L29-L30)）

### packages/experimental/webworker-packer/src/pack.ts

打包器主体：从组合配置算出包名花名册、物化依赖闭包、做可达性扫描与模块降级，最后压成确定性的 gzip 归档；另提供数据覆盖层的打包函数。

- 把运行时的清单路径与配置路径原样再导出为本模块的常量，决定镜像里这两个文件的落点（[packages/experimental/webworker-packer/src/pack.ts:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L35-L38)）
- `CONTRACT_FIELD` 固定为 `lowered`，即运行时据以判定镜像是否可挂载的清单字段名（[packages/experimental/webworker-packer/src/pack.ts:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L45)）
- 依据规则表建出三个 glob 匹配器：通用排除、工作区额外排除、页面资产判定，均开启 dot 匹配（[packages/experimental/webworker-packer/src/pack.ts:48-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L48-L54)）
- `packageNameOf` 从模块说明符切出包名，带 `@` 时取前两段（[packages/experimental/webworker-packer/src/pack.ts:143-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L143-L146)）
- `moduleNamesOf` 递归穿过嵌套 `config` 行表收集 `name` 字段，只把含 `@` 或 `/` 的名字当作模块说明符，从而排除内建行与元数据文档（[packages/experimental/webworker-packer/src/pack.ts:156-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L156-L166)）
- `rosterOf` 用条目列表的 YAML 方言解析组合配置，使 `!!js` 标量不被求值即可取出包名（[packages/experimental/webworker-packer/src/pack.ts:173-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L173-L177)）
- `treeRosterOf` 递归遍历一棵配置树，只解析 `.yml`/`.yaml` 文件并把其中的包名并入花名册（[packages/experimental/webworker-packer/src/pack.ts:184-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L184-L199)）
- `resolveDependency` 按 Node 的方式从导入方目录逐级上溯 `node_modules` 找到含 `package.json` 的目录并返回其真实路径（[packages/experimental/webworker-packer/src/pack.ts:207-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L207-L216)）
- `collectTree` 遍历目录收文件：默认跳过 `node_modules` 与点开头目录，开启保留模式时全部下钻；只收普通文件，路径分隔符统一为 `/`，并由传入的 keep 谓词决定去留（[packages/experimental/webworker-packer/src/pack.ts:231-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L231-L253)）
- `publishedFilter` 把清单 `files` 数组变成谓词：模式既匹配自身也匹配其整棵子树，`!` 模式从准入集里扣除，`package.json` 恒被保留（[packages/experimental/webworker-packer/src/pack.ts:263-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L263-L272)）
- `nameForDebugger` 先删掉末尾的 `sourceMappingURL` 注释，再追加 `//# sourceURL=` 行，使镜像内每个脚本在调试器里带上名字（[packages/experimental/webworker-packer/src/pack.ts:307-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L307-L328)）
- `debuggerNamer` 把 `node_modules/<包名>/...` 的镜像键改写成该包在仓库中的相对路径，外部包则保留原键（[packages/experimental/webworker-packer/src/pack.ts:339-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L339-L351)）
- 扫描前把全部候选条目灌进内存虚拟文件系统，以 `/` 结尾的键建成目录（[packages/experimental/webworker-packer/src/pack.ts:361-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L361-L365)）
- 用运行时自己的模块加载器做解析，并把所有被代理的模块名与前缀登记成同一个空对象工厂的静态模块（[packages/experimental/webworker-packer/src/pack.ts:367-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L367-L374)）
- 扫描队列以调用方给出的入口或默认的镜像入口种子起步（[packages/experimental/webworker-packer/src/pack.ts:376-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L376-L377)）
- 再把每个工作区包清单里的非通配导出面加进队列作为根；清单缺失或 JSON 解析失败则跳过（[packages/experimental/webworker-packer/src/pack.ts:378-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L378-L395)）
- 解析失败时按导入方分流：来自第三方目录的请求或 meta-resolve 请求记为容忍项，其余记为失败项（[packages/experimental/webworker-packer/src/pack.ts:405-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L405-L421)）
- 静态模块解析结果不入镜像，已访问路径去重，镜像中没有对应字节的路径跳过（[packages/experimental/webworker-packer/src/pack.ts:422-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L422-L428)）
- 非 JavaScript 条目与页面资产原样保留，不做降级也不继续展开（[packages/experimental/webworker-packer/src/pack.ts:429-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L429-L432)）
- 其余脚本交给运行时的降级函数改写，统计访问数与改写数，并把它报告出的模块请求与 meta-resolve 请求按所在目录继续入队（[packages/experimental/webworker-packer/src/pack.ts:433-440](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L433-L440)）
- 存在失败项时抛错终止打包，并把每条失败的导入方、说明符与原因列出（[packages/experimental/webworker-packer/src/pack.ts:441-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L441-L447)）
- 收尾时重排全部条目：非脚本原样带走，页面资产与非脚本之外的脚本按是否被走到决定保留还是丢弃，保留的一律追加调试器名字，并计入脚本数与丢弃数（[packages/experimental/webworker-packer/src/pack.ts:449-474](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L449-L474)）
- `dropExecutables` 把首两字节为 `#!` 的脚本条目从镜像中删除并回报名单（[packages/experimental/webworker-packer/src/pack.ts:487-498](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L487-L498)）
- `materialize` 以花名册为起点做广度遍历，跳过已收录的包与被替换掉的外部包（[packages/experimental/webworker-packer/src/pack.ts:510-518](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L510-L518)）
- 定位一个包时先查工作区索引，再退回 Node 式解析；都找不到就记入 missing 而不是中断（[packages/experimental/webworker-packer/src/pack.ts:519-523](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L519-L523)）
- 工作区包按其清单 `files` 的发布视图再叠加工作区排除表收文件，外部包只过通用排除表（[packages/experimental/webworker-packer/src/pack.ts:527-537](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L527-L537)）
- 记录每个包贡献的文件数，并沿 `dependencies` 继续展开；`peerDependencies` 只对工作区包展开（[packages/experimental/webworker-packer/src/pack.ts:538-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L538-L550)）
- `compressImage` 以最高压缩级别 gzip，并把头部的操作系统字节改写为 255，使同一棵树在不同平台压出相同字节（[packages/experimental/webworker-packer/src/pack.ts:555-578](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L555-L578)）
- `packVfsImage` 的虚拟根缺省取运行时默认根（[packages/experimental/webworker-packer/src/pack.ts:593](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L593)）
- 任何声明了却在磁盘上缺失的配置树直接抛错，不打出更薄的镜像（[packages/experimental/webworker-packer/src/pack.ts:595-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L595-L600)）
- 花名册由组合配置里的包名与所有开启 roster 扫描的配置树里的包名去重合并而成（[packages/experimental/webworker-packer/src/pack.ts:602-606](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L602-L606)）
- 组合配置本身写进镜像的配置路径，各配置树按各自 mount 复制进镜像并只过通用排除表（[packages/experimental/webworker-packer/src/pack.ts:608-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L608-L609)）
- 先丢可执行脚本，再以物化结果中属于工作区的包为根做可达性扫描（[packages/experimental/webworker-packer/src/pack.ts:611-614](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L611-L614)）
- 写出镜像清单，含虚拟根、profile 名、包装契约版本以及脚本数、访问数、改写数（[packages/experimental/webworker-packer/src/pack.ts:616-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L616-L623)）
- 按调用方给出的列表或运行时默认列表在镜像里建出空目录条目（[packages/experimental/webworker-packer/src/pack.ts:625-627](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L625-L627)）
- 打成 ustar 归档后压缩，并连同花名册、包计数、缺失依赖、被丢弃的可执行脚本、页面包名单与契约一起返回（[packages/experimental/webworker-packer/src/pack.ts:629-643](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L629-L643)）
- `packVfsOverlay` 对每棵树校验源目录存在，否则抛错（[packages/experimental/webworker-packer/src/pack.ts:657-661](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L657-L661)）
- 覆盖层 mount 归一化后必须以运行时许可的数据目录之一开头，且不得含空段、`.` 或 `..`，否则抛错，从而挡住替换配置、清单或模块的挂载点（[packages/experimental/webworker-packer/src/pack.ts:662-669](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L662-L669)）
- 覆盖层内容以保留目录的方式全量收取，绕开排除表与可达性处理，后面的树覆盖同路径的先前文件，最后同样确定性压缩（[packages/experimental/webworker-packer/src/pack.ts:670-672](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/pack.ts#L670-L672)）

### packages/experimental/webworker-packer/src/repository.ts

打包器的仓库侧适配：定位工作区包、通过命令行导出组合配置、读取配置树声明与预置样例，并把一次打包渲染成日志行。

- `WORKSPACE_SCAN_ROOTS` 限定只扫描四个目录下的包（[packages/experimental/webworker-packer/src/repository.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L23)）
- 组合配置的入口固定为命令行包的源码入口文件（[packages/experimental/webworker-packer/src/repository.ts:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L26-L29)）
- 预置样例内容的根目录路径写死在常量里（[packages/experimental/webworker-packer/src/repository.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L32)）
- `indexWorkspacePackages` 在遇到 `package.json` 的目录处停止下钻并按包名建索引，遍历时跳过 `node_modules` 与点开头目录（[packages/experimental/webworker-packer/src/repository.ts:51-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L51-L73)）
- `composeProfile` 建一个临时家目录，用它覆盖家目录环境变量后以子进程跑源码入口的 `--dump-default-config` 取出组合配置，缓冲上限 64 MiB，最后无论成败都删掉临时目录（[packages/experimental/webworker-packer/src/repository.ts:86-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L86-L97)）
- `configTrees` 读取命令行包清单里的 `dsh.configTrees`：缺省返回空表，非数组抛错（[packages/experimental/webworker-packer/src/repository.ts:116-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L116-L125)）
- 逐条校验声明必须含非空字符串 mount 与 path、`scanRoster` 若给出必须是布尔，且 mount 不得重复，任一不合规即抛错拒绝打包（[packages/experimental/webworker-packer/src/repository.ts:126-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L126-L139)）
- 把每条声明的 path 拼成绝对目录，并只在给出时带上 `scanRoster`（[packages/experimental/webworker-packer/src/repository.ts:140-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L140-L145)）
- `previewFixtures` 返回唯一一个样例定义，其 id、标签、描述与两棵挂在 `home` 与 `workspace` 的目录树写死在此（[packages/experimental/webworker-packer/src/repository.ts:155-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L155-L163)）
- `describePack` 按前缀累加字节算出各段体积，并挑出按体积排序的前 12 个包（[packages/experimental/webworker-packer/src/repository.ts:176-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L176-L184)）
- 报告行固定给出输出路径、花名册条数、包数与其中工作区包数、文件数、原始与压缩体积、配置段体积、脚本数与被丢弃的可执行脚本及逐字保留的页面包数、包装契约、改写与丢弃统计、被容忍的第三方未解析请求数，最后在有缺失依赖时逐条列出（[packages/experimental/webworker-packer/src/repository.ts:186-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/repository.ts#L186-L204)）

### packages/experimental/webworker-packer/src/rules.ts

打包规则表：镜像的包含与排除判定集中在这一个文件里，供打包主体消费。

- `EXCLUDE` 从每棵被收集的树里丢掉测试目录、覆盖率目录、sourcemap、tsbuildinfo、各类归档与声明文件（[packages/experimental/webworker-packer/src/rules.ts:16-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/rules.ts#L16-L29)）
- `EXCLUDE_WORKSPACE` 额外从工作区与内联包里丢掉 `src/` 与 `dist/`（[packages/experimental/webworker-packer/src/rules.ts:37-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/rules.ts#L37-L40)）
- `PAGE_ASSETS` 把两类 `lib/client.js` 路径标为页面资产，使它们不参与模块降级而逐字入镜像（[packages/experimental/webworker-packer/src/rules.ts:53-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/rules.ts#L53-L56)）
- `IMAGE_ENTRY_SEEDS` 列出五个没有任何镜像内文件引用、必须作为可达性扫描根的说明符（[packages/experimental/webworker-packer/src/rules.ts:65-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/rules.ts#L65-L71)）

### packages/experimental/webworker-packer/src/transform-image.ts

声明镜像条目类型与打包结果计数类型，并把降级契约版本转成打包侧常量。

- `WRAPPER_CONTRACT` 取自运行时的降级版本号，被写进镜像清单并在挂载时用于判定该镜像的脚本体是否按同一套包装语义生成（[packages/experimental/webworker-packer/src/transform-image.ts:12-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/src/transform-image.ts#L12-L18)）

### packages/experimental/webworker-packer/tsconfig.json

包级编译配置，声明源码目录、类型输出目录、类型集与工程引用。

- 无运行期机制

### packages/experimental/webworker-packer/tsdown.config.ts

包级打包配置，覆盖仓库默认只打库入口的行为。

- 入口列表把库、命令行与不变量伴生三个模块都打进 `lib/`，其中命令行产物正是 `bin.js` 转发的目标（[packages/experimental/webworker-packer/tsdown.config.ts:9-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/tsdown.config.ts#L9-L12)）
- 输出格式固定 ESM、平台 node、目标 es2024，且不改扩展名（[packages/experimental/webworker-packer/tsdown.config.ts:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/tsdown.config.ts#L13-L16)）
- 关闭声明文件生成与输出目录清理，使类型产物与已有文件得以保留（[packages/experimental/webworker-packer/tsdown.config.ts:17-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/webworker-packer/tsdown.config.ts#L17-L18)）
