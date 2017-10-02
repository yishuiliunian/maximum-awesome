ENV['HOMEBREW_CASK_OPTS'] = "--appdir=/Applications"

def brew_install(package, *args)
  versions = `brew list #{package} --versions`
  options = args.last.is_a?(Hash) ? args.pop : {}

  # if brew exits with error we install tmux
  if versions.empty?
    sh "brew install #{package} #{args.join ' '}"
  elsif options[:requires]
    # brew did not error out, verify tmux is greater than 1.8
    # e.g. brew_tmux_query = 'tmux 1.9a'
    installed_version = versions.split(/\n/).first.split(' ').last
    unless version_match?(options[:requires], installed_version)
      sh "brew upgrade #{package} #{args.join ' '}"
    end
  end
end

def load_plugins(file)
  array = []
  File.readlines('ApplicationPlugins/'+"#{file}.plugins").each { |plugin|
    plugin = plugin.gsub(/#.*#/,"")
    plugin = plugin.gsub(/\n/,"")
    key =  plugin.gsub(/\s+/,"")
    if key.length != 0
      array << plugin
    end
  }
  return array
end

def version_match?(requirement, version)
  # This is a hack, but it lets us avoid a gem dep for version checking.
  # Gem dependencies must be numeric, so we remove non-numeric characters here.
  version.gsub!(/[a-zA-Z]/, '')
  Gem::Dependency.new('', requirement).match?('', version)
end

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

def brew_cask_install(package, *options)
  output = `brew cask info #{package}`
  return unless output.include?('Not installed')

  sh "brew cask install --binarydir=#{`brew --prefix`.chomp}/bin #{package} #{options.join ' '}"
end

def step(description)
  description = "-- #{description} "
  description = description.ljust(80, '-')
  puts
  puts "\e[32m#{description}\e[0m"
end

def app_path(name)
  path = "/Applications/#{name}.app"
  ["~#{path}", path].each do |full_path|
    return full_path if File.directory?(full_path)
  end

  return nil
end

def app?(name)
  return !app_path(name).nil?
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

def link_file(original_filename, symlink_filename)
  original_path = File.expand_path(original_filename)
  symlink_path = File.expand_path(symlink_filename)
  if File.exists?(symlink_path) || File.symlink?(symlink_path)
    if File.symlink?(symlink_path)
      symlink_points_to_path = File.readlink(symlink_path)
      return if symlink_points_to_path == original_path
      # Symlinks can't just be moved like regular files. Recreate old one, and
      # remove it.
      ln_s symlink_points_to_path, get_backup_path(symlink_path), :verbose => true
      rm symlink_path
    else
      # Never move user's files without creating backups first
      mv symlink_path, get_backup_path(symlink_path), :verbose => true
    end
  end
  ln_s original_path, symlink_path, :verbose => true
end

def unlink_file(original_filename, symlink_filename)
  original_path = File.expand_path(original_filename)
  symlink_path = File.expand_path(symlink_filename)
  if File.symlink?(symlink_path)
    symlink_points_to_path = File.readlink(symlink_path)
    if symlink_points_to_path == original_path
      # the symlink is installed, so we should uninstall it
      rm_f symlink_path, :verbose => true
      backups = Dir["#{symlink_path}*.bak"]
      case backups.size
      when 0
        # nothing to do
      when 1
        mv backups.first, symlink_path, :verbose => true
      else
        $stderr.puts "found #{backups.size} backups for #{symlink_path}, please restore the one you want."
      end
    else
      $stderr.puts "#{symlink_path} does not point to #{original_path}, skipping."
    end
  else
    $stderr.puts "#{symlink_path} is not a symlink, skipping."
  end
end


def port_install(name)
  sh "sudo /opt/local/bin/port install #{name}"
end



namespace :install do
  desc 'Update or Install Brew'
  task :brew do
    step 'Homebrew'
    unless system('which brew > /dev/null || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
      raise "Homebrew must be installed before continuing."
    end
  end

  desc 'Install Homebrew Cask'
  task :brew_cask do
    step 'Homebrew Cask'
    system('brew untap phinze/cask') if system('brew tap | grep phinze/cask > /dev/null')
    unless system('brew tap | grep caskroom/cask > /dev/null') || system('brew tap caskroom/homebrew-cask')
      abort "Failed to tap caskroom/homebrew-cask in Homebrew."
    end

    unless system('brew tap | grep caskroom/drivers > /dev/null' || system('brew tap caskroom/drivers'))
      abort "Failed to tap caskroom/drivers in Homebrew"
    end

    brew_install 'brew-cask-completion'
  end

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


  desc 'Install port'
  task :macport do
    step 'MacPort'
    if (`sudo /opt/local/bin/port version`.include?"Version:")
      puts "MacPort already exist"
    else
      sh 'curl https://distfiles.macports.org/MacPorts/MacPorts-2.3.3.tar.bz2 -o MacPorts-2.3.3.tar.bz2'
      sh 'tar xjvf MacPorts-2.3.3.tar.bz2'
      sh 'cd MacPorts-2.3.3 && ./configure && make && sudo make install'
      sh 'pwd'
      sh 'rm -rf MacPorts-2.3.3*'
      sh './bin/checkBashrc.sh'
    end
  end



  task :ohmyzsh do
    step "oh my zsh"
    sh 'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
  end

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

  desc "Applications From Brew cask"
  task :cask_applications do
    step "Install Applications From Cask"
    apps = load_plugins('brew_cask')
    apps.each { |app|
      brew_cask_install app
    }
  end

  desc "Applications From Brew"
  task :brew_applications do
    step "Install Applications From Brew"
    apps = load_plugins('brew')
    apps.each { |app|
      step "Install #{app}"
      brew_install app
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
  Rake::Task['install:macport'].invoke
  Rake::Task['install:mas'].invoke
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
