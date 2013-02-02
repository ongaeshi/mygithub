# -*- coding: utf-8 -*-
#
# @file 
# @brief  Githubへのアクセス
# @author ongaeshi
# @date   2013/02/02

require 'github_api'

module Mygithub
  class GithubAccessor
    attr_reader :token
    
    def initialize(username, token)
      @username = username
      @token    = token

      # @todo なぜかSSL関連でエラーが出たので認証をOFFにしている
      # @github = Github.new(:oauth_token => @token)
      @github = Github.new do |config|
        config.endpoint    = 'https://api.github.com/'
        config.oauth_token = token                      # @todo 何故か'@token'にすると動かない
        config.adapter     = :net_http
        config.ssl         = {:verify => false}
      end      
    end

    def repo_names
      @github.repos.list(:user => 'ongaeshi').map {|r| r.full_name}
    end
  end
end
  

