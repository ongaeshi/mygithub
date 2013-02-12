# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/03

require 'milkode/cdweb/app'
require 'omniauth'
require 'omniauth-github'
require 'mygithub/settings'
require 'mygithub/cli_core'

use Rack::Session::Cookie
use OmniAuth::Builder do
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
  @setting = WebSetting.new
  haml :login, :layout => false
end

get '/auth/github/callback' do
  auth = request.env['omniauth.auth']

  # Setup mygithub.yaml
  settings = Mygithub::Settings.new
  settings.username = auth.extra[:raw_info][:login]
  settings.token    = auth.credentials[:token]
  settings.save

  # Done
  redirect '/update_all'
end

get '/update_all' do
  # Update repositories
  cli = Mygithub::CliCore.new
  cli.update([], {})

  # Reopen
  Milkode::Database.instance.open

  # Done
  redirect '/'
end

helpers do
  def goto_github
    settings = Mygithub::Settings.new
    username = settings.username
    "<a href='https://github.com/#{username}'>Goto Github : <img src='https://raw.github.com/github/media/master/octocats/blacktocat-32.png'></img></a>"
  end

  def goto_github_project(path)
    return "" if (path == "")

    image_href = 'https://raw.github.com/github/media/master/octocats/blacktocat-16.png'
      
    settings = Mygithub::Settings.new
    username = settings.username

    paths = path.split('/')

    if (paths.size == 1)
      "<a href='https://github.com/#{username}/#{paths[0]}'><img src='#{image_href}'></img></a>"
    else
      "<a href='https://github.com/#{username}/#{paths[0]}/tree/master/#{paths[1..-1].join('/')}'><img src='#{image_href}'></img></a>"
    end
  end

  # .search-summary に追加情報を表示したい時はこの関数をオーバーライド
  def search_summary_hook(path)
    goto_github_project(path)
  end
  
end
