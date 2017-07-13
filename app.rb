require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "library_system"})

get("/")do
@patrons = Patron.all()
  erb(:index)
end

post("/patrons") do
  name = params.fetch("name")
  patron = Patron.new({:name => name, :id => nil})
  patron.save()
  @patrons = Patron.all()
  erb(:index)
end

get("/patrons/new")do
  erb(:patron_form)
end


get('/patrons') do
  @patrons = Patron.all()
  erb(:patrons)
end

get("/patrons/:id") do
  @patron = Patron.find(params.fetch("id").to_i())
  erb(:patron)
end

post("/books") do
    title = params.fetch("title")
    author = params.fetch("author")
    patron_id = params.fetch("patron_id").to_i()
    book = Book.new({:title => title, :author => author, :patron_id => patron_id})
    book.save()
    @patron = Patron.find(patron_id)
    erb(:patron)
  end

get("/patrons/:id/edit")do
  @patron = Patron.find(params.fetch("id").to_i())
  erb(:patron_edit)
end

patch("/patrons/:id")do
  name = params.fetch("name")
  @patron = Patron.find(params.fetch("id").to_i())
  @patron.update({:name => name})
  erb(:patron)
end

delete("/patrons/:id")do
  @patron = Patron.find(params.fetch("id").to_i())
  @patron.delete()
  @patrons = Patron.all()
  erb(:index)
end
