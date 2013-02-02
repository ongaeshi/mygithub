# -*- coding: utf-8 -*-
#
# @file 
# @brief  Githubへのアクセス
# @author ongaeshi
# @date   2013/02/02

module Mygithub
  class Github
    attr_reader :token
    
    def initialize(token)
      @token = token
    end
    
    def token
      @token
    end
  end
end
  

