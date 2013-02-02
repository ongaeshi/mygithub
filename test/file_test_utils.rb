# -*- coding: utf-8 -*-
#
# @file
# @brief ファイルテスト用ユーティリティ
# @author ongaeshi
# @date 2011/02/21
#
# 使い方:
#
# class TestCdstk < Test::Unit::TestCase
#   include FileTestUtils
#  end
#
# すると以下のことを自動でやってくれます
#
# 1. tmpディレクトリの作成
# 2. tmpディレクトリに移動
# 3. テスト実行
# 4. 元のディレクトリに戻る
# 5. tmpディレクトリの削除
#

require 'fileutils'

module FileTestUtils
  def setup
    create_tmp_dir
    FileUtils.cd(@tmp_dir)
  end

  def teardown
    teardown_custom(true)
  end

  def teardown_custom(is_remove_dir)
    FileUtils.cd(@prev_dir)
    FileUtils.rm_rf(@tmp_dir) if (is_remove_dir)
  end

  def tmp_path(path)
    File.join @tmp_dir, path
  end

  private

  def create_tmp_dir
    @prev_dir = Dir.pwd
    @tmp_dir = File.join(File.dirname(__FILE__), "tmp")
    FileUtils.rm_rf(@tmp_dir)
    FileUtils.mkdir_p(@tmp_dir)
  end
end
