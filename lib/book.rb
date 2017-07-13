class Book

attr_reader(:title, :author, :patron_id)

define_method(:initialize) do |attributes|
  @title = attributes.fetch(:title)
  @author = attributes.fetch(:author)
  @patron_id = attributes.fetch(:patron_id)
end

define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      author = book.fetch("author")
      patron_id = book.fetch("patron_id").to_i() # The information comes out of the database as a string
      books.push(Book.new({:title => title, :author => author, :patron_id => patron_id}))
    end
    books
  end

  define_method(:save) do
      DB.exec("INSERT INTO books (title, author, patron_id) VALUES ('#{@title}', '#{@author}', #{@patron_id});")
    end

  define_method(:==) do |another_book|
        self.title().==(another_book.title()).&(self.patron_id().==(another_book.patron_id()))
   end
end
