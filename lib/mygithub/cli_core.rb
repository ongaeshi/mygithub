# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'mygithub/settings'
require 'milkode/cdstk/cdstk'
require 'milkode/cdweb/cli_cdweb'
require 'mygithub/github_accessor'
require 'milkode/cdstk/yaml_file_wrapper'
require 'mygithub/milkode_accessor'

module Mygithub
  class CliCore
    def initialize
      @settings = Settings.new
      @github   = GithubAccessor.new @settings.username, @settings.token
      @milk     = MilkodeAccessor.new Settings.default_database
    end

    def init(options)
      if (@settings.empty?)
        @settings.save unless options[:no_save]
        puts "Create -> #{Settings.default_filename}"
        puts "Please edit YAML settings!"
      else
        puts "Already exists '#{Settings.default_filename}'."
        puts "Please edit YAML settings!"
      end
    end

    def update(args, options)
      # initialize
      @milk.init
      @milk.create_milkweb_yaml(@github.avatar_url)

      # Get repo_names
      if args.empty?
        names = @github.repo_names.map {|r| r.sub(@settings.username + '/', "")}
      else
        names = args
      end

      # update or add
      add_repos    = []
      update_repos = []

      names.each do |name|
        next if name.match("/")
        
        unless @milk.exist? name
          add_repos << "git://github.com/#{@settings.username}/#{name}.git"
        else
          update_repos << name
        end
      end

      @milk.add add_repos       unless add_repos.empty?
      @milk.update update_repos unless update_repos.empty?
    end

    def web(options)
      @milk.web(options)
    end
  end
end


