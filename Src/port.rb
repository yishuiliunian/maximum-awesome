require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require 'rake'

def port_install(name)
  sh "sudo /opt/local/bin/port install #{name}"
end

namespace :install do
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
end
