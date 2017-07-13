class Patron

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
end

    define_singleton_method(:all) do
      returned_patrons = DB.exec("SELECT * FROM patrons;")
      patrons = []
      returned_patrons.each() do |patron|
        name = patron.fetch("name")
        id = patron.fetch("id").to_i()
        patrons.push(Patron.new({:name => name, :id => id}))
      end
      patrons
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


define_method(:save) do
      result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_patron|
          self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
        end

define_method(:update) do |attributes|
  @name = attributes.fetch(:name)
  @id = self.id()
  DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
end

define_method(:delete)do
  DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  DB.exec("DELETE FROM books WHERE patron_id = #{self.id()};")
end

end
