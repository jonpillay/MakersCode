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
    expect(albums.length).to eq 12
    expect(albums.first.title).to eq 'Doolittle'
    expect(albums.first.release_year).to eq "1989"
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
    expect(albums.length).to eq 13
    expect(albums.first.title).to eq 'Doolittle'
    expect(albums.first.release_year).to eq "1989"
    expect(albums.first.id).to eq '1'
    expect(albums.last.id).to eq '13'
    expect(albums.last.title).to eq 'Blue Lines'
    expect(albums.last.release_year).to eq '1991'
  end
  it "deletes an entry by id" do
    repo = AlbumRepository.new
    repo.revove_album_id(1)
    albums = repo.all
    expect(albums.first.title).to eq 'Surfer Rosa'
  end
  it "updates an artist" do
    repo = AlbumRepository.new
    repo.update_artist_details('Dance', 'Massive Attack')
    albums = repo.all
    expect(repo.find_artist_id(5)[0].genre).to eq 'Dance'
  end
end