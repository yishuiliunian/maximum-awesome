# MacSwiss

> 脱胎于Maximun Awesome后来经过各种重构和添加功能，变成了现在的模样。可以快速配置一台基本的mac 开发环境。

快速搭建Mac开发环境。运行该脚本将会把在mac上常用的包管理工具都安装上包括：gem, pip, brew, brew_cask, apn, npm, tpm.并且将会安装一大批默认的提高效率的程序和脚本，可以在ApplicationPlugins目录下面查看都有哪些程序。

## What's in it?

* [MacVim](https://github.com/macvim-dev/macvim) (independent or for use in a terminal)
* [iTerm 2](http://www.iterm2.com/)
* [tmux](http://tmux.github.io/)
* Awesome syntax highlighting with the [Solarized color scheme](http://ethanschoonover.com/solarized)
* oh my zsh
* nodejs & npm
* tpm , tmux plugins manager
* tmux-powerline
* Markdown Livedown
* Xcode Alcatraz
* mas 一个Mac App Store管理程序
* rvm ruby环境管理
* atom Github开源的编辑器


### vim

* `,d` brings up [NERDTree](https://github.com/scrooloose/nerdtree), a sidebar buffer for navigating and manipulating files
* `,t` brings up [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim), a project file filter for easily opening specific files
* `,b` restricts ctrlp.vim to open buffers
* `,a` starts project search with [ag.vim](https://github.com/rking/ag.vim) using [the silver searcher](https://github.com/ggreer/the_silver_searcher) (like ack, but faster)
* `ds`/`cs` delete/change surrounding characters (e.g. `"Hey!"` + `ds"` = `Hey!`, `"Hey!"` + `cs"'` = `'Hey!'`) with [vim-surround](https://github.com/tpope/vim-surround)
* `gcc` toggles current line comment
* `gc` toggles visual selection comment lines
* `vii`/`vai` visually select *in* or *around* the cursor's indent
* `Vp`/`vp` replaces visual selection with default register *without* yanking selected text (works with any visual selection)
* `,[space]` strips trailing whitespace
* `<C-]>` jump to definition using ctags
* `,l` begins aligning lines on a string, usually used as `,l=` to align assignments
* `<C-hjkl>` move between windows, shorthand for `<C-w> hjkl`

####  livedown preview
* LiveDownPreview open the preview window in Browser

### Nodejs & npm

### Xcode plugins manager ---- alcatraz

### pip

1. tushare
2. 基本的量化分析环境

### mas

mac app store管理工具

### atom编辑器

及插件安装

### RVM & GEM

### MacPort


### tmux

* `<C-a>` is the prefix
* mouse scroll initiates tmux scroll
* `prefix v` makes a vertical split
* `prefix s` makes a horizontal split

If you have three or more panes:
* `prefix +` opens up the main-horizontal-layout
* `prefix =` opens up the main-vertical-layout

You can adjust the size of the smaller panes in `tmux.conf` by lowering or increasing the `other-pane-height` and `other-pane-width` options.

## Install

    rake

## Update

    rake

This will update all installed plugins using Vundle's `:PluginInstall!`
command. Any errors encountered during this process may be resolved by clearing
out the problematic directories in ~/.vim/bundle. `:help PluginInstall`
provides more detailed information about Vundle.

## Customize
In your home directory, Maximum Awesome creates `.vimrc.local`, `.vimrc.bundles.local` and `.tmux.conf.local` files where you can customize
Vim and tmux to your heart’s content. However, we’d love to incorporate your changes and improve Vim and tmux
for everyone, so feel free to fork Maximum Awesome and open some pull requests!
