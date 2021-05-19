class BooksSerializer

  def initialize(books)
    @books = books
  end

  def as_json
    books.map do |book|
      {
        id: book.id,
        name: book.title,
        author_name: author_name(book.author),
        author_age: book.author ? book.author.age : "N/A"
      }  
    end
  end

  def author_name(author)
    "#{author.first_name} #{author.last_name}"
  end

  private

  attr_reader :books
end