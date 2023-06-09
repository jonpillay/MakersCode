require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = params[:name]
    if @name.include?('<script>')
      @name = ' Bozo. Nice try! You failed!'
      return erb(:hello)
    else
      return erb(:hello)
    end
  end
end