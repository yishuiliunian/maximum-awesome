require_relative "Src/fudation.rb"

ENV['HOMEBREW_CASK_OPTS'] = "--appdir=/Applications"

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


def get_backup_path(path)
  number = 1
  backup_path = "#{path}.bak"
  loop do
    if number > 1
      backup_path = "#{backup_path}#{number}"
    end
    if File.exists?(backup_path) || File.symlink?(backup_path)
      number += 1
      next
    end
    break
  end
  backup_path
end




namespace :install do

  task :alcatraz do
    step "xcode pulgins mamager Alcatraz"
    sh 'curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/deploy/Scripts/install.sh | sh'
  end

  desc "Mananger application cmd"
  task :mas do
    step "mas : Mac Apple Store Applications"
    brew_install 'mas'
    applications = load_plugins('mas')
    applications.each { |app|
      sh "mas install #{app}"
    }
  end

  desc "Atom"
  task :atom do
    step "atom"
    brew_cask_install 'atom'

    step "Atom Plugins"
    plugins = load_plugins('atom')
    plugins.each {|plugin|
       sh "apm install #{plugin}"
    }
  end
end

def filemap(map)
  map.inject({}) do |result, (key, value)|
    result[File.expand_path(key)] = File.expand_path(value)
    result
  end.freeze
end

COPIED_FILES = filemap(
  'vimrc.local'         => '~/.vimrc.local',
  'vimrc.bundles.local' => '~/.vimrc.bundles.local',
  'tmux.conf.local'     => '~/.tmux.conf.local'
)

LINKED_FILES = filemap(
  'vim'           => '~/.vim',
  'tmux'          => '~/.tmux',
  'tmux.conf'     => '~/.tmux.conf',
  'vimrc'         => '~/.vimrc',
  'vimrc.bundles' => '~/.vimrc.bundles',
  'zshrc'         => '~/.zshrc'
)



desc 'Install these config files.'
task :install do
  Rake::Task['install:brew'].invoke
  Rake::Task['install:brew_cask'].invoke
  Rake::Task['install:brew_applications'].invoke
  Rake::Task['install:cask_applications'].invoke
  Rake::Task['install:the_silver_searcher'].invoke
  Rake::Task['install:iterm'].invoke
  Rake::Task['install:reattach_to_user_namespace'].invoke
  Rake::Task['install:tmux'].invoke
  Rake::Task['install:tmux_plugins'].invoke
  Rake::Task['install:macvim'].invoke
  Rake::Task['install:rvm'].invoke
  Rake::Task['install:gem_applications'].invoke
  Rake::Task['install:pip'].invoke
  Rake::Task['install:pip_applications'].invoke
  Rake::Task['install:hammerspoon'].invoke
  Rake::Task['install:macport'].invoke
  Rake::Task['install:npm_applications'].invoke
  Rake::Task['install:mas'].invokRae
  # Rake::Task['install:alcatraz'].invoke
  Rake::Task['install:ohmyzsh'].invoke



  # TODO install gem ctags?
  # TODO run gem ctags?

  step 'symlink'

  LINKED_FILES.each do |orig, link|
    link_file orig, link
  end

  COPIED_FILES.each do |orig, copy|
    cp orig, copy, :verbose => true unless File.exist?(copy)
  end

  # Install Vundle and bundles
  Rake::Task['install:vundle'].invoke

  step 'iterm2 colorschemes'
  colorschemes = `defaults read com.googlecode.iterm2 'Custom Color Presets'`
  dark  = colorschemes !~ /Solarized Dark/
  light = colorschemes !~ /Solarized Light/
  sh('open', '-a', '/Applications/iTerm.app', File.expand_path('iterm2-colors-solarized/Solarized Dark.itermcolors')) if dark
  sh('open', '-a', '/Applications/iTerm.app', File.expand_path('iterm2-colors-solarized/Solarized Light.itermcolors')) if light

  step 'iterm2 profiles'
  puts
  puts "  Your turn!"
  puts
  puts "  Go and manually set up Solarized Light and Dark profiles in iTerm2."
  puts "  (You can do this in 'Preferences' -> 'Profiles' by adding a new profile,"
  puts "  then clicking the 'Colors' tab, 'Load Presets...' and choosing a Solarized option.)"
  puts "  Also be sure to set Terminal Type to 'xterm-256color' in the 'Terminal' tab."
  puts
  puts "  Enjoy!"
  puts
end


desc 'Uninstall these config files.'
task :uninstall do
  step 'un-symlink'

  # un-symlink files that still point to the installed locations
  LINKED_FILES.each do |orig, link|
    unlink_file orig, link
  end

  # delete unchanged copied files
  COPIED_FILES.each do |orig, copy|
    rm_f copy, :verbose => true if File.read(orig) == File.read(copy)
  end

  step 'homebrew'
  puts
  puts 'Manually uninstall homebrew if you wish: https://gist.github.com/mxcl/1173223.'

  step 'iterm2'
  puts
  puts 'Run this to uninstall iTerm:'
  puts
  puts '  rm -rf /Applications/iTerm.app'

  step 'macvim'
  puts
  puts 'Run this to uninstall MacVim:'
  puts
  puts '  rm -rf /Applications/MacVim.app'
end

task :default => :install
