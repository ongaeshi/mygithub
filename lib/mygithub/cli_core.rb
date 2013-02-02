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
      @github   = GithubAccessor.new @settings.token
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
      @milk.init
      @milk.create_milkweb_yaml

      if args.empty?
        repos = @github.repo_names
      else
        repos = args.map{|arg| @settings.username + '/' + arg }
      end

      # yaml = YamlFileWrapper.load(@dbdir)

      # repos.each do |name|
      #   p [name, yaml.find_name(args[0])]
      # end

      giturls = repos.map{|name| 'git://github.com/' + name + '.git'}
      @milk.add(giturls, {})
    end

    def web(options)
      @milk.web(options)
    end
  end
end


