# -*- coding: utf-8 -*-
#
# @file 
# @brief  Githubへのアクセス
# @author ongaeshi
# @date   2013/02/02

require 'github_api'
require 'date'

module Mygithub
  class GithubAccessor
    attr_reader :token
    
    def initialize(username, token)
      @username = username
      @token    = token

      begin
        @github = Github.new(:oauth_token => @token)
        avatar_url
      rescue Faraday::Error::ConnectionFailed
        puts "WARNING: Faraday::Error::ConnectionFailed: Change config.ssl = {verify: false}"
        @github = Github.new do |config|
          config.endpoint    = 'https://api.github.com/'
          config.user        = username
          config.oauth_token = token                      # @memo 何故か'@token'にすると動かない
          config.adapter     = :net_http
          config.ssl         = {:verify => false}
        end
      end
    end

    class Repository
      attr_accessor :pushed_at
      
      def initialize(repo)
        @repo      = repo
        @pushed_at = DateTime.parse(repo.pushed_at)
      end

      def full_name
        @repo.full_name
      end
    end

    def repo_names
      repos = []
      page       = 1

      while (true)
        r = @github.repos.list(:per_page => 100, :page => page).map {|r| Repository.new(r)}
        break if r.empty?
        repos += r
        page += 1
      end

      repos.sort_by{|r| r.pushed_at}.map{|r| r.full_name}
    end

    def username
      @username
    end

    def avatar_url
      @github.users.get(username).avatar_url      
    end
  end
end
  

