require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require_relative 'gem.rb'
require 'rake'

ZSH_COPIED_FILES = {}

ZSH_LINKED_FILES = filemap(
  'zshrc'         => '~/.zshrc'
)

namespace :install do
  task :ohmyzsh do
    step "oh my zsh"
    sh 'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
    step "Install antigen ---ZSH Plugins Manager"
    brew_install "antigen"
    gem_install 'lunchy'
    steupConfigureFiles(ZSH_LINKED_FILES, ZSH_COPIED_FILES)
  end
end
