# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/15

require 'mygithub/github_accessor'
require 'mygithub/settings'
require 'test_helper'

module Mygithub
  class TestGithubAccessor < Test::Unit::TestCase
    def setup
      # Need 'mygithub init'
      @settings = Settings.new
      assert_equal false, @settings.empty?

      # Create GithubAccessor
      @gh = GithubAccessor.new(@settings.username, @settings.token)
    end

    def test_token
      assert_equal @settings.token, @gh.token
    end

    def test_repo_names
      # p @gh.repo_names                                 # Exec test
      @gh.repo_names
    end
  end
end
