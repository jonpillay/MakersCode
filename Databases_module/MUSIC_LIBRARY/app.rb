require_relative 'lib/database_connection'
require_relative 'lib/album_repository'


#require_relative './lib/album_repository'
#require_relative './lib/artist_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    #@artist_repository = artist_repository
  end

  def print_artist(artist_obs)
    artist_obs.each{ |artist| @io.puts "* #{artist.id} - #{artist.name} Genre => #{artist.genre}" }
  end

  def print_albums(album_obs)
    album_obs.each.with_index(1){ |album, index| @io.puts "* #{index} - #{album.title}" }
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.

    DatabaseConnection.connect('music_library')
    repo = AlbumRepository.new

    while true
      @io.puts "Hello, what would you like to list? Enter 1 for Artists of 2 to list Albums or 3 to exit!"
      choice = @io.gets.chomp

      if choice == "1"
        result = repo.all_artists
        @io.puts "This is a list of all the artists"
        print_artist(result)
      elsif choice == "2"
        result = repo.all
        @io.puts "This is a list of all the albums"
        print_albums(result)
      elsif choice == "3"
        @io.puts "So long music lover!"
        break
      else
        @io.puts "Please make a valid option."
      end
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    #ArtistRepository.new
  )
  app.run
end

#app = Application.new('music_library_test', Kernel, AlbumRepository.new)

#app.run

=begin

DatabaseConnection.connect('music_library')

repo = AlbumRepository.new

result = repo.find_by_id(3)

result.each { |album| puts "#{album.title} from the year #{album.release_year}"}

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