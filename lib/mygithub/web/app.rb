# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/03

require 'milkode/cdweb/app'

MY_VIEWS = File.dirname(__FILE__) + '/views'

class Sinatra::Base
  # custom find_template from  https://github.com/sinatra/sinatra/issues/48
  def find_template(views, name, engine, &block)
    [MY_VIEWS, views].each { |v| super(v, name, engine, &block) }
  end
end

get '/auth/github' do
  'OAuth Github'
end

get '/css/mygithub.css' do
  scss :mygithub
end
