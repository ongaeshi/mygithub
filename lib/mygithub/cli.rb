# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'rubygems'
require 'thor'
require 'mygithub/cli_core'
require 'mygithub/settings'

module Mygithub
  class CLI < Thor
    desc "init", "Init setting"
    option :no_save, :type => :boolean, :desc => 'No save.'
    def init
      CliCore.new.init(options)
    end

    desc "web", "Startup web interface"
    option :db, :default => Settings.default_database
    option :host, :default => '127.0.0.1', :aliases => '-o'
    option :port, :default => 9292, :aliases => '-p'
    option :server, :default => 'thin', :aliases => '-s'
    option :no_browser, :type => :boolean, :default => false, :aliases => '-n', :type => :boolean, :desc => 'Do not launch browser.'
    option :customize, :type => :boolean, :desc => 'Create customize file.'
    def web
      CliCore.new.web(options)
    end
  end
end







