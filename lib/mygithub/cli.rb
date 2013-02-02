# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'rubygems'
require 'thor'
require 'mygithub/cli_core'

module Mygithub
  class CLI < Thor
    desc "init", "Init setting."
    option :no_save, :type => :boolean, :desc => 'No save.'
    def init
      CliCore.new.init(options)
    end
  end
end







