require_relative './album'
require_relative './artist'

class AlbumRepository

  def create_album_objs(results)
    albums = []
    results.each do |details|
      album = Album.new
      album.id = details['id']
      album.title = details['title'] 
      album.release_year = details['release_year']
      albums << album
    end
    return albums
  end

  def create_artist_objs(results)
    artists = []
    results.each do |details|
      artist = Artist.new
      artist.id = details['id']
      artist.name = details['name'] 
      artist.genre = details['genre']
      artists << artist
    end
    return artists
  end

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, title, release_year FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])
    create_album_objs(result_set)
  end

  def all_artists
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])
    create_artist_objs(result_set)
  end

  def find_by_id(id)
    sql = 'SELECT title, release_year FROM albums WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    create_album_objs(result_set)
  end

  def find_artist_id(id)
    sql = 'SELECT * FROM artists WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    create_artist_objs(result_set)
  end

  def insert_album(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'
    params = [album.title, album.release_year, album.artist_id]
    DatabaseConnection.exec_params(sql, params)
  end
  
  def update_artist_details(value, artist)
    sql = 'UPDATE artists SET genre = $1 WHERE name = $2;'
    params = [value, artist]
    DatabaseConnection.exec_params(sql, params)
  end

  def revove_album_id(id)
    sql = 'DELETE FROM albums WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end

  def revove_album_name(artist)
    sql = 'DELETE FROM albums WHERE artist_id.name = $1;'
    params = [artist]
    DatabaseConnection.exec_params(sql, params)
  end

end