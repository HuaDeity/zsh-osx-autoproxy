# zsh-osx-autoproxy

Auto Set Proxy for macOS zsh

## Requirements

Set system proxy on your macOS

## Install

### In your ~/.zshrc

Simply clone this repository and source the script:

```bash
git clone https://github.com/HuaDeity/zsh-osx-autoproxy.git
echo "source ${{q-}PWD/zsh-osx-autoproxy/zsh-osx-autoproxy.zsh}"
```

Then, enable auto proxy in the current interactive shell:

```bash
source ./zsh-osx-autoproxy/zsh-osx-autoproxy.zsh
```

### With a plugin manager

[Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

1. Clone this repository in oh-my-zsh's plugins directory:

```bash
git clone https://github.com/HuaDeity/zsh-osx-autoproxy.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-osx-autoproxy
```

2. Activate the plugin in ~/.zshrc:

```bash
plugins=( [plugins...] zsh-osx-autoproxy)
```

3. Restart zsh (such as by opening a new instance of your terminal emulator).

## Commands

```bash
proxy
noproxy
```

There are two commands you can use.

## See Also

Waiting for Linux user making bash-linux-autoproxy.

[powershell-windows-autoproxy](https://github.com/HuaDeity/powershell-windows-autoproxy)

## Thanks

Thanks to [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) for the install instruction.
