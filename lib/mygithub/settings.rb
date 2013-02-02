# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/22

require 'yaml'
require 'fileutils'

module Mygithub
  class Settings
    def self.default_dir
      File.expand_path('~/.mygithub')
    end

    def self.default_filename
      File.join default_dir, 'mygithub.yaml'
    end

    def self.default_database
      File.join default_dir, 'database'
    end
    
    def initialize(filename = Settings.default_filename)
      @filename = filename
      
      if File.exist?(@filename)
        open(@filename) do |f|
          @data = YAML.load(f.read)
        end
      else
        @data = {
          'username' => '',
          'token'    => ''
        }
        @is_empty = true
      end
    end

    def save
      FileUtils.mkdir_p File.dirname(@filename)
      
      open(@filename, "w") do |f|
        f.write YAML.dump(@data)
      end
    end

    def username
      @data['username']
    end

    def token
      @data['token']
    end

    def empty?
      !@is_empty.nil?
    end
  end
end


