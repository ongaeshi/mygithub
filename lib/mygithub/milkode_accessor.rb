# -*- coding: utf-8 -*-
#
# @file 
# @brief  Milkodeへのアクセス
# @author ongaeshi
# @date   2013/02/02

require 'milkode/cdstk/cdstk'
require 'milkode/cdweb/cli_cdweb'
require 'milkode/cdstk/yaml_file_wrapper'

module Mygithub
  class MilkodeAccessor
    attr_reader :dbdir

    def initialize(dbdir)
      @dbdir = dbdir
      @cdstk = Milkode::Cdstk.new($stdout, @dbdir)
      @yaml = YamlFileWrapper.load_if(@dbdir)
    end

    def init
      unless File.exist? @dbdir
        FileUtils.mkdir_p @dbdir
        @cdstk.init({})
        @yaml = YamlFileWrapper.load_if(@dbdir)        
      end
    end

    def create_milkweb_yaml(icon_url)
      filename = File.join(@dbdir, 'milkweb.yaml')

      # @todo アイコンはAPI経由で取得する
      File.open(filename, "w") do |f|
        f.write <<EOF
---
:home_title : "MyGithub"
:home_icon  : #{icon_url}

:header_title: "MyGithub"
:header_icon : #{icon_url}

:display_about_milkode: false
EOF
      end
    end

    def add(path)
      @cdstk.add([path], {})
    end

    def exist?(name)
      !@yaml.find_name(name).nil?
    end

    def update(name)
      @cdstk.update([name], {})      
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
  end
end
  

