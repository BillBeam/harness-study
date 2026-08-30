---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · native/landlock-run/packages/linux-arm64
---

# native/landlock-run/packages/linux-arm64

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 2 个文件、5 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### native/landlock-run/packages/linux-arm64/README.md

linux-arm64 平台包的说明，讲这个包只装一个静态 musl 二进制、由入口包解析成文件路径、从不被 import。

- 无运行期机制

### native/landlock-run/packages/linux-arm64/package.json

linux-arm64 平台包的 npm 清单：声明平台过滤条件、随包发布的内容与打包闸门，不声明任何 JS 入口。

- `os: linux` 与 `cpu: arm64` 使安装器只在匹配主机上拉取该包（[native/landlock-run/packages/linux-arm64/package.json:10-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/linux-arm64/package.json#L10-L15)）
- `files` 让 tarball 只带上 `bin/` 与 `prebuilds.json`（[native/landlock-run/packages/linux-arm64/package.json:16-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/linux-arm64/package.json#L16-L20)）
- `prepack` 钩子在打包前跑二进制存在性与 ELF 架构校验（[native/landlock-run/packages/linux-arm64/package.json:21-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/linux-arm64/package.json#L21-L23)）
- `engines` 要求 Node ≥20（[native/landlock-run/packages/linux-arm64/package.json:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/linux-arm64/package.json#L24-L26)）
