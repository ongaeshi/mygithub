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
      @token    = token

      # @todo なぜかSSL関連でエラーが出たので認証をOFFにしている
      # @github = Github.new(:username => username, :oauth_token => @token)
      @github = Github.new do |config|
        config.endpoint    = 'https://api.github.com/'
        config.user        = username
        config.oauth_token = token                      # @memo 何故か'@token'にすると動かない
        config.adapter     = :net_http
        config.ssl         = {:verify => false}
      end      
    end

    def repo_names
      @github.repos.list.map {|r| r.full_name}
    end

    def username
      @github.users.user
    end

    def avatar_url
      @github.users.get(username).avatar_url      
    end
  end
end
  

