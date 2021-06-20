class BookSerializer
  def initialize(book)
    @book = book
  end

  def as_json
    {
      id: book.id,
      name: book.title,
      author_name: author_name(book.author),
      author_age:  book.author.age
    } 
  end

  def author_name(author)
    "#{author.first_name} #{author.last_name}"
  end

  private 

  attr_reader :book
end