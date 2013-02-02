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
      repo_names = []
      page       = 1

      while (true)
        r = @github.repos.list(:per_page => 100, :page => page).map {|r| r.full_name}
        break if r.empty?
        repo_names += r
        page += 1
      end

      repo_names
    end

    def username
      @github.users.user
    end

    def avatar_url
      @github.users.get(username).avatar_url      
    end
  end
end
  

