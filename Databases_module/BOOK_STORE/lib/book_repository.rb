require_relative './book'

class BookRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, title, author_name FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])
    books = []
    result_set.each do |details|
      book = Book.new
      book.id = details['id']
      book.title = details['title'] 
      book.author_name = details['author_name']
      books << book
    end
    return books
  end 

  # Executes the SQL query:
  # SELECT id, name, cohort_name FROM students;

  # Returns an array of Student objects.

end