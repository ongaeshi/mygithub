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
    
    def initialize(token)
      @token = token
    end

    def repositories
      Github.repos.list user: 'wycats'
    end
  end
end
  

