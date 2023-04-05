require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  get '/' do
    return erb(:hello)
  end

  get '/hello' do
    @name = params[:name]
    return erb(:helloname)
  end

  get '/names' do
    names = params[:names]
    result = names.join(', ')
    return result
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]
    return "Thanks #{name}, you sent this message: \"#{message}\""
  end

  post '/sort-names' do
    names = params[:names]
    names = names.split(/\W+/).sort.join(',')
    return names
  end  

  configure :development do
    register Sinatra::Reloader
  end
end