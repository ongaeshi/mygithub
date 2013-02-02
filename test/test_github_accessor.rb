# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/15

require 'mygithub/github_accessor'
require 'test_helper'

module Mygithub
  class TestGithubAccessor < Test::Unit::TestCase
    def setup
      @gh = GithubAccessor.new(ENV['GITHUB_USER'], ENV['GITHUB_TOKEN']) # @todo 仮
    end

    def test_token
      assert_equal ENV['GITHUB_TOKEN'], @gh.token
    end

    def test_repo_names
      assert_equal @gh.repo_names[0], "ongaeshi/aaa" # @todo 仮テスト
    end
  end
end
