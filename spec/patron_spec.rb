require("spec_helper")

describe(Patron)do

  describe(".all")do
    it("starts off with no patrons")do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe("#name")do
    it("tells you the title") do
      patron = Patron.new({:name => "betty", :id => nil})
      expect(patron.name()).to(eq("betty"))
    end
  end

  describe("#id")do
    it("sets the patron ID when a new patron added") do
      patron = Patron.new({:name => "betty", :id => nil})
      patron.save()
      expect(patron.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save")do
    it("lets you save a new patron to the database")do
      patron = Patron.new({:name => "betty", :id => nil})
      patron.save()
      expect(Patron.all()).to(eq([patron]))
    end
  end

  describe("#==") do
    it("is the same patron if has the same name") do
      patron1 = Patron.new({:name => "betty", :id => nil})
      patron2 = Patron.new({:name => "betty", :id => nil})
      expect(patron1).to(eq(patron2))
    end
  end

describe(".find")do
  it("returns a patron by patron ID") do
    test_patron = Patron.new({:name => "betty", :id => nil})
    test_patron.save()
    test_patron2 = Patron.new({:name => "sherry", :id => nil})
    test_patron2.save()
    expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
  end
end


describe("#books") do
      it("returns an array of books for that patron") do
        test_patron = Patron.new({:name => "betty", :id => nil})
        test_patron.save()
        test_book = Book.new({:title => "true colors", :author => "pau", :patron_id => test_patron.id()})
        test_book.save()
        test_book2 = Book.new({:title => "about vegas", :author => "geo", :patron_id => test_patron.id()})
        test_book2.save()
        expect(test_patron.books()).to(eq([test_book, test_book2]))
      end
    end

    describe("#update") do
          it("lets you update patrons in the database") do
            patron = Patron.new({:name => "wanjiko", :id => nil})
            patron.save()
            patron.update({:name => "shiko"})
            expect(patron.name()).to(eq("shiko"))
          end
        end

        describe("#delete") do
              it("lets you delete a patron from the database") do
                patron = Patron.new({:name => "wanjiko", :id => nil})
                patron.save()
                patron2 = Patron.new({:name => "sherry", :id => nil})
                patron2.save()
                patron.delete()
                expect(Patron.all()).to(eq([patron2]))
              end

              it("deletes a patron's books from the database") do
                patron = Patron.new({:name => "betty", :id => nil})
                patron.save()
                book = Book.new({:title => "true colors", :author => "pau", :patron_id => patron.id()})
                book.save()
                book2 = Book.new({:title => "about vegas", :author => "geo", :patron_id => patron.id()})
                book2.save()
                patron.delete()
                expect(Book.all()).to(eq([]))
              end
            end
end
