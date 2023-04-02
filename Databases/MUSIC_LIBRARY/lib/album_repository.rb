require 'album'

class AlbumRepository

  def create_objs(results)
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

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, title, release_year FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])
    create_objs(result_set)
  end

  def find_by_id(id)
    sql = 'SELECT title, release_year FROM albums WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    create_objs(result_set)
  end

  def create_album(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'
    params = [album.title, album.release_year, album.artist_id]
    DatabaseConnection.exec_params(sql, params)
  end

  # Executes the SQL query:
  # SELECT id, name, cohort_name FROM students;

  # Returns an array of Student objects.

end