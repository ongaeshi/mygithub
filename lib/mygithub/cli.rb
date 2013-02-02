# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'rubygems'
require 'thor'

module Mygithub
  class CLI < Thor
    desc "init", "Init setting."
    def init
      puts "Hello, Mygithub!"
    end
  end
end
