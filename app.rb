require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "library_system"})

get("/")do
  erb(:index)
end

get("/patrons/new")do
  erb(:patron_form)
end

post("/patrons") do
  name = params.fetch("name")
  patron = Patron.new({:name => name, :id => nil})
  patron.save()
  erb(:patron_success)
end

get('/patrons') do
  @patrons = Patron.all()
  erb(:patrons)
end

get("/patrons/:id") do
  @patrons = Patron.find(params.fetch("id").to_i())
  erb(:patron)
end

post("/books") do
    title = params.fetch("title")
    author = params.fetch("author")
    patron_id = params.fetch("patron_id").to_i()
    @patron = Patron.find(patron_id)
    @book = Book.new({:title => title, :author => author, :patron_id => patron_id})
    @book.save()
    erb(:book_success)
  end
