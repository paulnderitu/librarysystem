class Patron

  @@all_patrons=[]

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
end

define_method(:save) do
  @@all_patrons.push(self)
end

define_singleton_method(:all) do
  @@all_patrons
end

define_singleton_method(:find) do |id|
  found_patron = nil
  Patron.all().each() do |patron|
    if patron.id().==(id)
      found_patron = patron
    end
  end
  found_patron
end

define_method(:books) do
  patron_books = []

  books = DB.exec("SELECT * FROM books WHERE patron_id = #{self.id()};")
      books.each() do |book|
        title = book.fetch("title")
        author = book.fetch("author")
        patron_id = book.fetch("patron_id").to_i()
        patron_books.push(Book.new({:title => title, :author => author, :patron_id => patron_id}))
      end
      patron_books
end
end
