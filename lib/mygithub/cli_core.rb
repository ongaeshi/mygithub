# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'mygithub/settings'

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
  end
end


