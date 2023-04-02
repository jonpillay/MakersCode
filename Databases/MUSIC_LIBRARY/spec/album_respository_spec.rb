require 'album_repository'

RSpec.describe AlbumRepository do
  def reset_music_tables
    seed_sql = File.read('spec/album_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
    connection.exec(seed_sql)
  end
  before(:each) do
    reset_music_tables
  end
  it "returns album information" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 13
    expect(albums.first.title).to eq 'Bold As Love'
    expect(albums.first.release_year).to eq "1967"
    expect(albums.first.id).to eq '1'
  end
  it "returns album information, adds an album and returns updated information" do
    repo = AlbumRepository.new
    album = Album.new
    album.title = 'Blue Lines'
    album.release_year = 1991
    album.artist_id = 5
    repo.insert_album(album)
    albums = repo.all
    expect(albums.length).to eq 14
    expect(albums.first.title).to eq 'Bold As Love'
    expect(albums.first.release_year).to eq "1967"
    expect(albums.first.id).to eq '1'
  end
end