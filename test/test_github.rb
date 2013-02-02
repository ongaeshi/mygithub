# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/15

require 'mygithub/github'
require 'test_helper'

module Mygithub
  class TestGithub < Test::Unit::TestCase
    def test_token
      gh = Github.new(ENV['GITHUB_TOKEN']) # @todo 仮
      assert_equal ENV['GITHUB_TOKEN'], gh.token
    end
  end
end
