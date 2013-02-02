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

module Mygithub
  class CliCore
    def initialize
      @settings = Settings.new
      @dbdir    = Settings.default_database
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
      cdstk = create_cdstk
      gh    = create_github

      # Init database
      unless File.exist? @dbdir
        FileUtils.mkdir_p @dbdir
        cdstk.init({})
      end

      # Create milkweb.yaml
      create_milkweb_yaml
      
      # Add git repositories
      if args.empty?
        repos = gh.repo_names
      else
        repos = args.map{|arg| @settings.username + '/' + arg }
      end

      giturls = repos.map{|name| 'git://github.com/' + name + '.git'}

      cdstk.add(giturls, {})
    end

    def web(options)
      opts = {
        :environment   => ENV['RACK_ENV'] || "development",
        :pid           => nil,
        :Port          => options[:port],
        :Host          => options[:host],
        :AccessLog     => [],
        :config        => "config.ru",
        # ----------------------------
        :server        => options[:server],
        :LaunchBrowser => !options[:no_browser],
        :DbDir         => options[:db],
      }

      Milkode::Cdstk.new($stdout, options[:db]).assert_compatible
      Milkode::CLI_Cdweb.execute_with_options($stdout, opts)
    end

    private

    def create_github
       GithubAccessor.new(@settings.token)
    end

    def create_cdstk
      Milkode::Cdstk.new($stdout, Settings.default_database)
    end

    def create_milkweb_yaml
      filename = File.join(@dbdir, 'milkweb.yaml')

      # @todo アイコンはAPI経由で取得する
      File.open(filename, "w") do |f|
        f.write <<EOF
---
:home_title : "MyGithub"
:home_icon  : "http://www.gravatar.com/avatar/6377451175704e2d367ce508bffc1fa5"

:header_title: "MyGithub"
:header_icon : "http://www.gravatar.com/avatar/6377451175704e2d367ce508bffc1fa5"

:display_about_milkode: false
EOF
      end
    end
  end
end


