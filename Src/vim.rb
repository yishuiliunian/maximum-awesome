require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require 'rake'

namespace :install do
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
