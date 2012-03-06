#!/usr/bin/env ruby

require 'yaml'
require 'heroku/client'

class HerokuCloner
  attr_reader :apps

  # If invoked via the symlink, grab the target
  WD = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
  def initialize
    creds = YAML.load_file("#{File.dirname(WD)}/.creds.yml")
    @heroku = Heroku::Client.new(creds['username'],creds['password'])
    @apps = []
  end

  # @heroku.list returns nested array [[appname,email],[appname,email]]
  # Rather than having me type the app name, lets prepend an
  # integer index to each array and have me just enter that instead
  # [[1,appname,email],[2,appname,email]]
  def list
    @apps = @heroku.list
    1.upto(@apps.size) do |idx|
      @apps[idx - 1].unshift idx
    end
    @apps
  end

  # If the index points to a repo, then clone it
  def do_clone index
    @apps.each do |app|
      if app.include? index
        puts 'Cloning...'
        `git clone git@heroku.com:#{app[1]}.git -o heroku`
      end
    end
  end
end

hc = HerokuCloner.new
hc.list.each do |app|
  puts "#{app[0]}: \t#{app[1]}"
end

puts "Which app do you want to clone?"
repo = gets.chomp.to_i

if repo >= 1 and repo <= hc.apps.length
  hc.do_clone repo
else
  puts 'Out of range'
end
