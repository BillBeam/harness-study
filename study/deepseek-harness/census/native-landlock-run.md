---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · native/landlock-run
---

# native/landlock-run

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 16 个文件、80 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### native/landlock-run/AGENTS.md

该目录的维护者说明，讲这套 Landlock 启动器的分包布局、运行期安全规则、命令与打包约束。

- 无运行期机制

### native/landlock-run/README.md

启动器包族的面向使用者说明：安装方式、公开 API 用法、支持矩阵与本地开发命令。

- 无运行期机制

### native/landlock-run/package.json

该子仓库的私有工作区根清单，把构建、类型检查、测试与发布各阶段绑定到具体脚本。

- `private: true` 使这个工作区根本身不被发布（[native/landlock-run/package.json:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/package.json#L3)）
- `scripts` 把 `build:ts`/`build:native`/`test`/`gha:matrix` 及 `release:*` 各步骤映射到 `scripts/` 下的具体文件（[native/landlock-run/package.json:8-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/package.json#L8-L24)）

### native/landlock-run/scripts/assemble-prebuilds.mjs

把 CI 各构建腿上传的 `prebuild-<包名>` 产物装配回各平台包的 `bin/` 并做校验，由 `release:assemble-prebuilds` 调用。

- 产物根目录不存在时抛错终止（[native/landlock-run/scripts/assemble-prebuilds.mjs:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/assemble-prebuilds.mjs#L18-L20)）
- 装配前把每个平台包的 `bin/` 整个删掉重建（[native/landlock-run/scripts/assemble-prebuilds.mjs:24-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/assemble-prebuilds.mjs#L24-L28)）
- 产物目录名必须能映射到 `prebuild-<平台包>`，否则抛错（[native/landlock-run/scripts/assemble-prebuilds.mjs:30-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/assemble-prebuilds.mjs#L30-L38)）
- 逐文件复制进平台包并把权限设为 0755（[native/landlock-run/scripts/assemble-prebuilds.mjs:39-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/assemble-prebuilds.mjs#L39-L45)）
- 装配完成后对每个平台包跑一次二进制校验（[native/landlock-run/scripts/assemble-prebuilds.mjs:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/assemble-prebuilds.mjs#L48-L51)）

### native/landlock-run/scripts/build.ts

本机原生构建脚本：按签入的平台矩阵，用 `musl-gcc` 把 C 源编译进对应平台包的 `bin/`，由 `build:native` 调用。

- `TOOLS` 表把 `prebuilds.json` 里的 `tool` 名映射到唯一的 C 源文件（[native/landlock-run/scripts/build.ts:28-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/build.ts#L28-L30)）
- 非 Linux 主机打印说明后以状态 1 退出（[native/landlock-run/scripts/build.ts:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/build.ts#L34-L38)）
- 遍历 `packages/*/prebuilds.json`，只收集 `platform` 等于本机 `linux-<arch>` 的目标（[native/landlock-run/scripts/build.ts:40-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/build.ts#L40-L54)）
- 本机平台没有任何声明目标时以状态 1 退出（[native/landlock-run/scripts/build.ts:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/build.ts#L55-L58)）
- 未知 `tool` 名或非 `static-musl` 的 `kind` 都以状态 1 退出（[native/landlock-run/scripts/build.ts:60-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/build.ts#L60-L69)）
- 以 `-std=c11 -Os -Wall -Wextra -Werror -static -s` 调用 `musl-gcc` 产出二进制，失败即以状态 1 退出（[native/landlock-run/scripts/build.ts:70-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/build.ts#L70-L84)）

### native/landlock-run/scripts/bump-release.mjs

版本推进脚本：把工作区根与所有 `packages/*` 统一到一个版本，刷新仓库锁文件并做发布校验，由 `release:bump` 调用。

- 子命令统一以 `CI=true` 运行，非零状态即以同一状态退出（[native/landlock-run/scripts/bump-release.mjs:20-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/bump-release.mjs#L20-L30)）
- 递增类型要求当前版本是纯 `x.y.z`，否则抛错（[native/landlock-run/scripts/bump-release.mjs:36-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/bump-release.mjs#L36-L42)）
- 显式目标版本允许带预发布后缀，直接采用（[native/landlock-run/scripts/bump-release.mjs:45-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/bump-release.mjs#L45-L52)）
- `major`/`minor`/`patch` 分别按位递增并清零低位（[native/landlock-run/scripts/bump-release.mjs:54-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/bump-release.mjs#L54-L57)）
- 所有已发布包的当前版本必须一致，否则抛错（[native/landlock-run/scripts/bump-release.mjs:60-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/bump-release.mjs#L60-L70)）
- 缺少参数时打印用法并以状态 1 退出（[native/landlock-run/scripts/bump-release.mjs:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/bump-release.mjs#L72-L75)）
- 把目标版本写回根与每个包的 `package.json`（[native/landlock-run/scripts/bump-release.mjs:77-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/bump-release.mjs#L77-L86)）
- 随后在仓库根只刷新锁文件（跳过脚本），并运行发布校验（[native/landlock-run/scripts/bump-release.mjs:88-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/bump-release.mjs#L88-L89)）

### native/landlock-run/scripts/commit-release.mjs

一条命令完成版本推进、暂存与提交，由 `release:commit` 调用；打标签留给人工。

- 缺少参数时打印用法并以状态 1 退出（[native/landlock-run/scripts/commit-release.mjs:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/commit-release.mjs#L26-L29)）
- 子命令统一以 `CI=true` 在该目录运行，非零状态即以同一状态退出（[native/landlock-run/scripts/commit-release.mjs:14-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/commit-release.mjs#L14-L24)）
- 先执行版本推进脚本（[native/landlock-run/scripts/commit-release.mjs:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/commit-release.mjs#L31)）
- 暂存根清单、各包清单与仓库锁文件，并以 `release(landlock-run): <版本>` 提交（[native/landlock-run/scripts/commit-release.mjs:33-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/commit-release.mjs#L33-L40)）

### native/landlock-run/scripts/github-matrix.mjs

从签入的平台矩阵推导 CI 与发布工作流的 job 矩阵，由 `gha:matrix` 调用并把 JSON 写到标准输出。

- `RUNNERS` 表规定每个 `platform` 用哪个 runner，缺失即抛错（[native/landlock-run/scripts/github-matrix.mjs:14-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/github-matrix.mjs#L14-L26)）
- CI 矩阵对去重后的每个平台产出一条 `{platform, runner}`（[native/landlock-run/scripts/github-matrix.mjs:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/github-matrix.mjs#L36-L41)）
- 发布矩阵对每个平台包产出一条，含包名、目录、runner 与 `prebuild-<包名>` 产物名（[native/landlock-run/scripts/github-matrix.mjs:43-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/github-matrix.mjs#L43-L53)）
- 未知或缺失的 target 打印用法并以状态 1 退出（[native/landlock-run/scripts/github-matrix.mjs:61-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/github-matrix.mjs#L61-L64)）
- 把选中的矩阵序列化成 JSON 写入标准输出（[native/landlock-run/scripts/github-matrix.mjs:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/github-matrix.mjs#L66)）

### native/landlock-run/scripts/pack-release.mjs

把所有待发布包按发布顺序打成 tarball 并写出顺序文件，由 `release:pack` 调用。

- 解析 `--current-platform-only` 开关，非开关参数作为输出目录，缺省为 `dist/npm`（[native/landlock-run/scripts/pack-release.mjs:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/pack-release.mjs#L20-L22)）
- 本机平台包按 `prebuilds.json` 的 `platform` 与当前 `platform-arch` 比对筛出（[native/landlock-run/scripts/pack-release.mjs:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/pack-release.mjs#L24-L27)）
- 打包前清空并重建输出目录（[native/landlock-run/scripts/pack-release.mjs:47-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/pack-release.mjs#L47-L48)）
- 平台包用 `npm pack`（保留可执行位），入口包用 `pnpm pack`（做工作区协议转换）（[native/landlock-run/scripts/pack-release.mjs:50-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/pack-release.mjs#L50-L65)）
- 每个包打完立即断言预期 tarball 文件存在，否则抛错（[native/landlock-run/scripts/pack-release.mjs:67-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/pack-release.mjs#L67-L72)）
- 把发布顺序写入 `publish-order.txt`（[native/landlock-run/scripts/pack-release.mjs:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/pack-release.mjs#L75)）

### native/landlock-run/scripts/publish-release.mjs

按 `publish-order.txt` 顺序把已打包的 tarball 发布到 npm registry，由 `release:publish` 调用。

- 列出被视为"写入未落定"的 registry 错误码（[native/landlock-run/scripts/publish-release.mjs:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L32)）
- 单个 tarball 最多尝试 4 次，两次发布之间与首个退避都是 2000ms（[native/landlock-run/scripts/publish-release.mjs:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L35-L42)）
- 用 sha512 计算本地 tarball 的 integrity 字符串（[native/landlock-run/scripts/publish-release.mjs:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L58-L60)）
- 直接从 tarball 里解出 `package/package.json` 取包名与版本，缺字段即抛错（[native/landlock-run/scripts/publish-release.mjs:66-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L66-L74)）
- 查询 registry 上该版本的 integrity：404 视作不存在，其他失败抛错，空值抛错（[native/landlock-run/scripts/publish-release.mjs:82-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L82-L94)）
- 预发布版本发布时打 `next` 标签，正式版本不带标签参数（[native/landlock-run/scripts/publish-release.mjs:106-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L106-L112)）
- 发布报错后回查 registry，若该版本已存在且 integrity 与本地一致就视为成功（[native/landlock-run/scripts/publish-release.mjs:114-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L114-L120)）
- 非瞬时错误或用尽次数即抛错，否则按 2 的幂退避后重试（[native/landlock-run/scripts/publish-release.mjs:121-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L121-L130)）
- 主循环对每个 tarball 先查 registry：已存在且 integrity 不同即抛错，一致则跳过（[native/landlock-run/scripts/publish-release.mjs:140-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L140-L156)）
- 只有真正发生过发布时才在两次发布之间插入间隔（[native/landlock-run/scripts/publish-release.mjs:157-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/publish-release.mjs#L157-L162)）

### native/landlock-run/scripts/repo.mjs

各发布脚本共用的辅助模块：包发现、签入的预构建矩阵读取与平台二进制校验。

- 以 `e_machine` 表把 `cpu` 值映射到 ELF 机器码（[native/landlock-run/scripts/repo.mjs:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/repo.mjs#L18)）
- 有 `prebuilds.json` 的目录判为平台包，其余带 `package.json` 的判为入口包（[native/landlock-run/scripts/repo.mjs:24-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/repo.mjs#L24-L39)）
- 发布顺序固定为平台包在前、入口包在后（[native/landlock-run/scripts/repo.mjs:41-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/repo.mjs#L41-L44)）
- 清单里缺失或不受支持的 `cpu` 直接抛错（[native/landlock-run/scripts/repo.mjs:52-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/repo.mjs#L52-L58)）
- 每个声明的二进制必须存在，否则抛出带补救指引的错误（[native/landlock-run/scripts/repo.mjs:60-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/repo.mjs#L60-L64)）
- 每个二进制必须带可执行位，否则抛错（[native/landlock-run/scripts/repo.mjs:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/repo.mjs#L65-L72)）
- 读取文件偏移 18 处的 ELF `e_machine`，与声明架构不符即抛错（[native/landlock-run/scripts/repo.mjs:73-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/repo.mjs#L73-L77)）
- `bin/` 中出现未在 `prebuilds.json` 声明的文件即抛错（[native/landlock-run/scripts/repo.mjs:79-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/repo.mjs#L79-L86)）

### native/landlock-run/scripts/verify-entry-lib.mjs

入口包的 `prepack` 闸门：在打包前确认构建产物存在。

- 缺少 `lib/index.js` 或 `lib/index.d.ts` 时打印指引并以状态 1 退出，阻止打出没有 JS 的 tarball（[native/landlock-run/scripts/verify-entry-lib.mjs:19-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-entry-lib.mjs#L19-L24)）

### native/landlock-run/scripts/verify-launcher-binary.mjs

平台包的 `prepack` 闸门：在打包前确认声明的二进制存在且架构正确。

- 校验目标目录取自命令行参数，缺省用当前工作目录（[native/landlock-run/scripts/verify-launcher-binary.mjs:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-launcher-binary.mjs#L22)）
- 调用共享的平台二进制校验，任何失败都打印原因并以状态 1 退出（[native/landlock-run/scripts/verify-launcher-binary.mjs:24-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-launcher-binary.mjs#L24-L30)）

### native/landlock-run/scripts/verify-packed-install.mjs

发布路径彩排：不真正发布，而是检查已打包 tarball 的载荷、装进仓库外的临时消费者、字节比对安装后的二进制，并用装好的入口包跑真实确认。

- 输出目录与 `--current-platform-only` 开关来自命令行参数（[native/landlock-run/scripts/verify-packed-install.mjs:31-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L31-L34)）
- 期望的 tarball 缺失即抛错（[native/landlock-run/scripts/verify-packed-install.mjs:43-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L43-L49)）
- 打包后的清单若带 `preinstall`/`install`/`postinstall`/`prepare` 任一生命周期脚本即抛错（[native/landlock-run/scripts/verify-packed-install.mjs:77-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L77-L83)）
- 打包后的依赖字段中若仍留有 `workspace:` 协议即抛错（[native/landlock-run/scripts/verify-packed-install.mjs:84-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L84-L90)）
- 解压 tarball 后把 `package/` 移进临时消费者的 `node_modules` 对应位置（[native/landlock-run/scripts/verify-packed-install.mjs:101-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L101-L112)）
- 按模式确定应存在的 tarball 集合并逐个断言（[native/landlock-run/scripts/verify-packed-install.mjs:126-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L126-L131)）
- 打包后入口包的 `optionalDependencies` 必须与平台包集合逐字相等，否则抛错（[native/landlock-run/scripts/verify-packed-install.mjs:133-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L133-L144)）
- 在系统临时目录建一个只装本地 tarball、不接触 registry 的 ESM 消费者工程（[native/landlock-run/scripts/verify-packed-install.mjs:146-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L146-L154)）
- 对安装后的每个二进制做 sha256 字节比对，与工作区构建不符即抛错（[native/landlock-run/scripts/verify-packed-install.mjs:155-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L155-L168)）
- Linux 主机上矩阵里没有对应平台包时抛错（[native/landlock-run/scripts/verify-packed-install.mjs:169-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L169-L171)）
- 生成的驱动脚本断言解析出的启动器路径是绝对路径且指向平台包目录（[native/landlock-run/scripts/verify-packed-install.mjs:176-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L176-L189)）
- Linux 分支断言启动器存在且可执行，再跑探测；`NALR_REQUIRE_LANDLOCK=1` 时探测结果为不可用即失败，否则跳过后续证明（[native/landlock-run/scripts/verify-packed-install.mjs:191-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L191-L203)）
- 真实约束证明：只授只读根时写入必须失败且文件不落盘，追加读写授权后写入必须成功且内容匹配（[native/landlock-run/scripts/verify-packed-install.mjs:204-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L204-L214)）
- 非 Linux 分支断言回退路径不存在且探测结果为不可用（[native/landlock-run/scripts/verify-packed-install.mjs:215-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L215-L219)）
- 用当前 Node 可执行文件在临时消费者目录里跑该驱动脚本，非零状态即退出（[native/landlock-run/scripts/verify-packed-install.mjs:221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-packed-install.mjs#L221)）

### native/landlock-run/scripts/verify-release.mjs

发布校验：确认各包版本一致、标签与版本吻合，并可选地校验各平台包的预构建二进制。

- 标签前缀固定为 `refs/tags/landlock-run-v`（[native/landlock-run/scripts/verify-release.mjs:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-release.mjs#L13)）
- 所有待发布包的版本必须唯一，否则列出各包版本并抛错（[native/landlock-run/scripts/verify-release.mjs:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-release.mjs#L16-L26)）
- `RELEASE_PUBLISH=true` 时必须从该前缀的标签运行，否则抛错（[native/landlock-run/scripts/verify-release.mjs:28-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-release.mjs#L28-L33)）
- 从标签运行时标签中的版本必须与包版本一致，否则抛错（[native/landlock-run/scripts/verify-release.mjs:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-release.mjs#L34-L39)）
- 带 `--prebuilds` 参数时对每个平台包再跑一次二进制校验（[native/landlock-run/scripts/verify-release.mjs:44-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/scripts/verify-release.mjs#L44-L53)）

### native/landlock-run/tsconfig.json

该子仓库的 TypeScript 根配置，只做类型检查并引用入口包项目。

- 无运行期机制
