# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'rubygems'
require 'thor'
require 'mygithub/github'

module Mygithub
  class CLI < Thor
    desc "init", "Init setting."
    def init
      puts "Hello, Mygithub!"

      gh = Github.new(ENV['GITHUB_TOKEN']) # @todo Dirty
      p gh.token
    end
  end
end
