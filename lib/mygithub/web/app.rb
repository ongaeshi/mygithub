# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/03

require 'milkode/cdweb/app'
require 'omniauth'
require 'omniauth-github'

use Rack::Session::Cookie
use OmniAuth::Builder do
  # provider :github, '507d8ff7541315a61b21', '8a62747fc27f1570370669d5495afdfb4f86682f', scope: "user,repo"
  provider :github, '507d8ff7541315a61b21', '8a62747fc27f1570370669d5495afdfb4f86682f'
end

MY_VIEWS = File.dirname(__FILE__) + '/views'

class Sinatra::Base
  # custom find_template from  https://github.com/sinatra/sinatra/issues/48
  def find_template(views, name, engine, &block)
    [MY_VIEWS, views].each { |v| super(v, name, engine, &block) }
  end
end

get '/css/mygithub.css' do
  scss :mygithub
end

get '/login' do
  <<-HTML
  <a href='/auth/github'>Sign in with Github</a>
    HTML
end

get '/auth/github/callback' do
  auth = request.env['omniauth.auth']
  p [auth.credentials[:token], auth.extra[:raw_info][:login]]
  # redirect '/'
end

