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
    end

    def init
      unless File.exist? @dbdir
        FileUtils.mkdir_p @dbdir
        @cdstk.init({})
      end
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

    def add(args, options)
      @cdstk.add(args, options)
    end
  end
end
  

