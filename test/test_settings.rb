# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

require 'mygithub/settings'
require 'test_helper'

module Mygithub
  class TestSettings < Test::Unit::TestCase
    include FileTestUtils
    
    def test_default_filename
      assert_match /\.mygithub\/mygithub\.yaml/, Settings.default_filename
    end

    def test_default_database
      assert_match /\.mygithub\/database/, Settings.default_database
    end

    def test_empty
      obj = Settings.new('mygithub.yaml') # データが無い場合は新規作成
      assert_equal ""  , obj.username
      assert_equal ""  , obj.token
      assert_equal true, obj.empty?
      obj.save
    end

    def test_exist_yaml
      obj = Settings.new(tmp_path('../data/.mygithub/mygithub.yaml'))
      assert_equal "ongaeshi"               , obj.username
      assert_equal "this0is1ongaeshis2token", obj.token
      assert_equal false                    , obj.empty?
    end

    def teardown
      teardown_custom(true)
    end
  end
end
