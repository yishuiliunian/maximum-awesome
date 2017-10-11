# MacSwiss

> 脱胎于Maximun Awesome后来经过各种重构和添加功能，变成了现在的模样。可以快速配置一台基本的mac 开发环境。

快速搭建Mac开发环境。运行该脚本将会把在mac上常用的包管理工具都安装上包括：gem, pip, brew, brew_cask, apm, npm, tpm.并且将会安装一大批默认的提高效率的程序和脚本，可以在ApplicationPlugins目录下面查看都有哪些程序。

## What's in it?


作为一个配置工具，会将一个基本的开发环境配置好。

> 因为循环依赖的问题，在使用该脚本的时候您需要先自行下载Xcode，并且同意其license

可以使用该脚本安全的基本的包管理工具包括：

1. brew
2. brew cask
3. gem [Ruby 包管理]
4. pip [Python 包管理]
5. apm [Atom 插件管理器]
6. npm [Node 包管理]
7. tpm [Tmux 插件管理]
8. vbundle [Vim 插件管理]
9. MacPort


并且可以安装以下优秀的软件：

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


### 最经典的terminal开发环境

oymyzsh + iterm2 + tmux + powerline

### 优秀的可编程窗口管理

hammerspoon + awesome-hammerspoon



### Mac Office 全家桶

* keynote
* numbers
* pages

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

在Vim中编辑macdown，可以通过浏览器直接预览


### pip

1. tushare
2. 基本的量化分析环境

### mas

mac app store管理工具

### atom编辑器

Atom及插件安装.

* vim模式
* 各种编程基本插件



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

如果你想全量安装可以直接使用：
~~~
    rake
~~~

该命令会将按照默认的配置对您的电脑进行配置。

如果你只想安装某些功能，可以通过

~~~
rake install:<安装的配置>
~~~

来进行安装。

各个安装包管理工具将会安装的软件在ApplicationPlugins目录下面，你可以增删改来满足自己的定制化需求。目前在这些里面的包都是楼主经过好长时间沉淀下来的优秀软件。

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
