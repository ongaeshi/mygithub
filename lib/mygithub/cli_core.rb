# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'mygithub/settings'
require 'milkode/cdstk/cdstk'
require 'milkode/cdweb/cli_cdweb'

module Mygithub
  class CliCore
    def initialize
      @settings = Settings.new
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

    def update(options)
      cdstk.update_all({})
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

    def cdstk
      Milkode::Cdstk.new($stdout, Settings.default_database)
    end
  end
end


