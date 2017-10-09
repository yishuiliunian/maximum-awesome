require_relative 'brew.rb'
require_relative 'utilities.rb'
def version_match?(requirement, version)
  # This is a hack, but it lets us avoid a gem dep for version checking.
  # Gem dependencies must be numeric, so we remove non-numeric characters here.
  version.gsub!(/[a-zA-Z]/, '')
  return false
  # hiden hack magical line
  #Gem::Dependency.new('', requirement).match?('', version)
end

def brew_install(package, *args)
  versions = `brew list #{package} --versions`
  options = args.last.is_a?(Hash) ? args.pop : {}

  # if brew exits with error we install tmux
  if versions.empty?
    sh "brew install #{package} #{args.join ' '}", verbose:false do |ok, status|
      unless ok
        WARNING status
      end
    end
  elsif options[:requires]
    # brew did not error out, verify tmux is greater than 1.8
    # e.g. brew_tmux_query = 'tmux 1.9a'
    installed_version = versions.split(/\n/).first.split(' ').last
    unless version_match?(options[:requires], installed_version)
      sh "brew upgrade #{package} #{args.join ' '}" do |ok, status|
        unless ok
          WARNING status
        end
      end
    end
  end
end


namespace :install do
  desc 'Update or Install Brew'
  task :brew do
    step 'Homebrew'
    unless system('which brew > /dev/null || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
      raise "Homebrew must be installed before continuing."
    end
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
