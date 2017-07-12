class Book

@@all_books = []

attr_reader(:title, :author, :patron_id)

define_method(:initialize) do |attributes|
  @title = attributes.fetch(:title)
  @author = attributes.fetch(:author)
  @patron_id = attributes.fetch(:patron_id)
end

define_method(:save) do
  @@all_books.push(self)
end

define_singleton_method(:all) do
  @@all_books
end

end
