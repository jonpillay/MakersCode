# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums/:id' do
    @id = params[:id]
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    album = album_repo.find(@id)
    artists = artist_repo.all
    @title = album.title
    @release_year = album.release_year
    @artist = artist_repo.find(album.artist_id)

    return erb(:album)
  end

  get '/albums' do
    album_repo = AlbumRepository.new
    @albums = album_repo.all
    @artists = ArtistRepository.new
    return erb(:albums)
  end

  post '/albums' do
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    repo = AlbumRepository.new    
    repo.create(album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artists)
  end

  get '/artists/:id' do
    @id = params[:id]
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @artist = artist_repo.find(@id)
    @artist_albums = album_repo.find_by_artist(@id)
    return erb(:artist)
  end

  post '/artists' do
    repo = ArtistRepository.new
    return erb(:artists)
  end
end