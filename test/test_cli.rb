# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'mygithub/cli.rb'
require 'test_helper'

module Mygithub
  class TestCLI < Test::Unit::TestCase
    def setup
      $stdout = StringIO.new
      @orig_stdout = $stdout
    end

    def teardown
      $stdout = @orig_stdout
    end

    def test_no_arg
      assert_match /Tasks:/, command("")
    end

    def test_init
      assert_match /mygithub.yaml/, command("init --no-save")
    end

    private

    def command(arg)
      CLI.start(arg.split)
      $stdout.string
    end
  end
end


