# Dotfiles

使用 Nix 和 Home Manager 管理命令行工具与配置。Yazi 插件由 `ya` 单独管理，不纳入 Home Manager，以保持 Nix 配置简单。

## 初始化 Yazi 插件

在新机器上应用 Home Manager 配置后，运行：

```sh
ya pkg install
```

这会按 [`config/yazi/package.toml`](config/yazi/package.toml) 锁定的版本安装插件，不会升级。若启动 Yazi 时出现 `Lua runtime failed`，并提示无法加载 `plugins/git.yazi/main.lua`，也可运行这条命令补装插件。

需要升级插件时，手动运行 `ya pkg upgrade`，并检查 `git diff -- config/yazi/package.toml`。升级会改动锁定版本，不是初始化所必需的步骤。
