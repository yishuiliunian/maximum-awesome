require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require_relative 'oymyzsh.rb'
require 'rake'

namespace :install do
  desc 'Install The Silver Searcher'
  task :the_silver_searcher do
    step 'the_silver_searcher'
    brew_install 'the_silver_searcher'
  end


  desc 'Install iTerm'
  task :iterm do
    step 'iterm2'
    unless app? 'iTerm'
      brew_cask_install 'iterm2'
    end
  end


  desc 'Install ctags'
  task :ctags do
    step 'ctags'
    brew_install 'ctags'
  end

  desc 'Install reattach-to-user-namespace'
  task :reattach_to_user_namespace do
    step 'reattach-to-user-namespace'
    brew_install 'reattach-to-user-namespace'
  end

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
    if not Dir.exists?(path)
      sh "git clone https://github.com/tmux-plugins/tpm #{path}"
    end
    install_tmux_plugin 'erikw', 'tmux-powerline'
    sh "~/.tmux/plugins/tmux-powerline/generate_rc.sh"
    sh "mv ~/.tmux-powerlinerc.default ~/.tmux-powerlinerc"
  end

  desc 'Install MacVim'
  task :macvim do
    step 'MacVim'
    unless app? 'MacVim'
      brew_cask_install 'macvim'
    end

    bin_dir = File.expand_path('~/bin')
    bin_vim = File.join(bin_dir, 'vim')
    unless ENV['PATH'].split(':').include?(bin_dir)
      puts 'Please add ~/bin to your PATH, e.g. run this command:'
      puts
      puts %{  echo 'export PATH="~/bin:$PATH"' >> ~/.bashrc}
      puts
      puts 'The exact command and file will vary by your shell and configuration.'
    end

    FileUtils.mkdir_p(bin_dir)
    unless File.executable?(bin_vim)
      File.open(bin_vim, 'w', 0744) do |io|
        io << <<-SHELL
#!/bin/bash
exec /Applications/MacVim.app/Contents/MacOS/Vim "$@"
        SHELL
      end
    end
  end

  desc 'Install Vundle'
  task :vundle do
    step 'vundle'
    install_github_bundle 'VundleVim','Vundle.vim'
    sh '~/bin/vim -c "PluginInstall!" -c "q" -c "q"'
  end

end
