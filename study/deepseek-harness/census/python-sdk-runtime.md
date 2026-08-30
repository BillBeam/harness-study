---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · python/sdk-runtime
---

# python/sdk-runtime

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、30 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### python/sdk-runtime/README.md

该 Python 运行时轮子包的说明文档，介绍安装后的命令、模块 API、打包产物与构建流程。

- 无运行期机制

### python/sdk-runtime/hatch_build.py

hatchling 构建钩子，在打轮子时校验平台清单与产物负载并指定轮子标签。

- `_load_platforms` 读取同目录 `platforms.json`，读不到或解析失败时抛 `RuntimeError`（[python/sdk-runtime/hatch_build.py:14-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L14-L18)）
- 清单必须是非空对象，且每个条目只含字符串的 `tag` 与 `executable`，否则抛错（[python/sdk-runtime/hatch_build.py:19-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L19-L32)）
- 模块导入时即加载并校验平台清单到 `_PLATFORMS`（[python/sdk-runtime/hatch_build.py:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L35)）
- `_host_platform_tag` 把 `platform.machine()`/`platform.system()` 归一为 `macos-`/`linux-`/`win-` 加架构的键，查不到时抛错（[python/sdk-runtime/hatch_build.py:38-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L38-L54)）
- `initialize` 对 `editable` 版本直接返回，不做任何校验或标签改写（[python/sdk-runtime/hatch_build.py:61-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L61-L62)）
- 目标为 `sdist` 时抛错，只允许构建平台轮子（[python/sdk-runtime/hatch_build.py:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L63-L66)）
- 平台标签取自环境变量 `DSH_RUNTIME_PLATFORM_TAG`，否则用宿主标签，且必须在清单中唯一命中，否则列出受支持标签抛错（[python/sdk-runtime/hatch_build.py:68-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L68-L74)）
- 按标签推导期望产物清单：主可执行文件加 `-rg`/`-rg.exe` 侧车，macOS 再加 `-spawn-helper`，与 `runtime/` 目录里实际文件逐一比对，不一致即抛错（[python/sdk-runtime/hatch_build.py:75-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L75-L92)）
- 非 Windows 标签下检查每个产物的属主可执行位，缺失即抛错（[python/sdk-runtime/hatch_build.py:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L93-L95)）
- 将构建数据标记为非纯 Python、关闭标签推断，并把轮子标签固定为 `py3-none-<platform_tag>`（[python/sdk-runtime/hatch_build.py:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/hatch_build.py#L96-L98)）

### python/sdk-runtime/package.json

私有的仅依赖清单，定义被打进 Python 运行时可执行文件的 Node 包闭包。

- `private: true` 使该根不被发布（[python/sdk-runtime/package.json:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/package.json#L5)）
- 依赖列表逐条枚举打包进可执行文件的工作区包，决定打包后的 `dsh` 能加载哪些插件与提供者（[python/sdk-runtime/package.json:7-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/package.json#L7-L132)）

### python/sdk-runtime/pyproject.toml

该轮子的 Python 打包清单，声明构建后端、安装后的命令与打包/排除的文件。

- 构建后端固定为 `hatchling==1.30.1`（[python/sdk-runtime/pyproject.toml:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/pyproject.toml#L1-L3)）
- `requires-python = ">=3.10"` 限制可安装的解释器版本（[python/sdk-runtime/pyproject.toml:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/pyproject.toml#L10)）
- 安装后的 `dsh` 控制台命令绑定到 `deepseek_harness_runtime:main`（[python/sdk-runtime/pyproject.toml:20-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/pyproject.toml#L20-L21)）
- 构建时把注入的 `deepseek-harness-sdk-runtime-*` 产物计入 artifacts，并排除 `runtime/node` 目录（[python/sdk-runtime/pyproject.toml:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/pyproject.toml#L24-L26)）
- 轮子目标只打包 `src/deepseek_harness_runtime`（[python/sdk-runtime/pyproject.toml:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/pyproject.toml#L28-L29)）
- 为 wheel 与 sdist 两个目标都挂上自定义构建钩子，使 `hatch_build.py` 在这两条路径上都执行（[python/sdk-runtime/pyproject.toml:31-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/pyproject.toml#L31-L33)）

### python/sdk-runtime/src/deepseek_harness_runtime/__init__.py

Python 模块入口，定位随轮子分发的 `dsh` 运行时载体并以进程替换方式执行它。

- `_PLATFORM_TAGS` 与 `_ARCH_TAGS` 把 `sys.platform` 与机器名映射为产物命名用的平台/架构标记（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:34-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L34-L35)）
- `bundled_package_dir` 以模块所在目录为根，缺少 `deepseek-harness-runtime.json` 元数据文件时抛 `FileNotFoundError`（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:46-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L46-L52)）
- `bundled_runtime_path` 按平台标记拼出 `runtime/deepseek-harness-sdk-runtime-<tag>`（Windows 加 `.exe`），文件缺失时抛出带获取途径提示的错误（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L65-L72)）
- 同一函数要求 ripgrep 侧车存在，Windows 用 `-rg.exe`、其余用 `-rg`，缺失即抛错（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:73-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L73-L82)）
- macOS 标记下还要求 `-spawn-helper` 存在，缺失即抛错（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:83-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L83-L89)）
- `resolve_bundled_launch_args` 的载体选择顺序为显式 `mode` 参数、`DSH_RUNTIME_MODE` 环境变量、默认 exe；`node` 走开发载体，其余值抛 `ValueError`（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:105-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L105-L113)）
- `_current_platform_tag` 拒绝未知平台或架构，并额外拒绝非 x64 的 Windows 与非 arm64 的 macOS，错误文本列出受支持组合（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:116-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L116-L130)）
- `_node_launch_args` 定位 `runtime/node/node_modules/@deepseek-ai/dsh/lib/bin.js`，缺失时抛错（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:133-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L133-L149)）
- node 载体还要求 `PATH` 上有 `node`，通过 `shutil.which` 查找，找不到即抛错，命中则返回 `(node, bin.js)` 两元 argv（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:150-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L150-L156)）
- `main` 在 `DSH_HOME` 缺失或全为空白时向 stderr 打印说明并以退出码 2 结束（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:161-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L161-L167)）
- `main` 把解析出的载体 argv 与 `sys.argv[1:]` 拼接，并用 `os.execvpe` 携带当前环境替换掉 Python 进程（[python/sdk-runtime/src/deepseek_harness_runtime/__init__.py:168-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk-runtime/src/deepseek_harness_runtime/__init__.py#L168-L169)）
