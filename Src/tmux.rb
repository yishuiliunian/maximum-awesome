require_relative 'brew.rb'
require_relative 'utilities.rb'
require 'pathname'
def install_github_bundle(user, package)
  unless File.exist? File.expand_path("~/.vim/bundle/#{package}")
    sh "git clone https://github.com/#{user}/#{package} ~/.vim/bundle/#{package}"
  end
end

def install_tmux_plugin(user, package)
  unless File.exist? File.expand_path("~/.tmux/plugins/#{package}")
    sh "git clone https://github.com/#{user}/#{package}.git ~/.tmux/plugins/#{package}"
  end
end


TMUX_COPIED_FILES = filemap(
  'tmux.conf.local'     => '~/.tmux.conf.local'
)

TMUX_LINKED_FILES = filemap(
  'tmux.conf'     => '~/.tmux.conf',
)

namespace :install do
  desc 'Install tmux'
  task :tmux do
    step 'tmux'
    # tmux copy-pipe function needs tmux >= 1.8
    brew_install 'tmux', :requires => '>= 2.1'
  end

  desc "Install tmux pulgins"
  task :tmux_plugins do
    step 'tmux plugins'
    path = File.expand_path("~")+'/.tmux/plugins/tpm'
    tmux_home = File.expand_path("~/.tmux")

    if not Dir.exists?(path)
      puts  "path is #{tmux_home}"
      if not Dir.exists?(tmux_home)
        FileUtils.mkdir(tmux_home)
        puts tmux_home
      end
      FileUtils.mkdir_p(path)
      sh "git clone https://github.com/tmux-plugins/tpm #{path}"
    end
    install_tmux_plugin 'erikw', 'tmux-powerline'
    sh "~/.tmux/plugins/tmux-powerline/generate_rc.sh"
    sh "mv ~/.tmux-powerlinerc.default ~/.tmux-powerlinerc"
  end

  task :tmux_all do
    step "TMUX --- The Terminal Manager"
    Rake::Task['install:tmux'].invoke
    step "Tmux configuration"
    steupConfigureFiles(TMUX_LINKED_FILES, TMUX_COPIED_FILES)
    Rake::Task['install:tmux_plugins'].invoke
  end
end
