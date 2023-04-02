require_relative 'lib/database_connection'
require_relative 'lib/album_repository'


DatabaseConnection.connect('music_library')

repo = AlbumRepository.new

result = repo.find_by_id(3)

result.each { |album| puts "#{album.title} from the year #{album.release_year}"}

=begin

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, title FROM albums;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end

=end