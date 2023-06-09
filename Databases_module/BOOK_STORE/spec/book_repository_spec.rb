require 'book_repository'

RSpec.describe BookRepository do
  def reset_books_table
    seed_sql = File.read('spec/seeds_book_store_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end
  before(:each) do 
    reset_books_table
  end
  it "returns book information" do
    repo = BookRepository.new
    books = repo.all
    expect(books.length).to eq 2
    expect(books.first.title).to eq 'Emma'
    expect(books.first.author_name).to eq 'Jane Austin'
    expect(books.first.id).to eq '1'
  end
end