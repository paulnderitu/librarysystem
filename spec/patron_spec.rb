require("spec_helper")

describe(Patron)do

  describe(".all")do
    it("starts off with no patrons")do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe("#save")do
    it("lets you save a new patron to the database")do
      patron = Patron.new({:name => "betty", :id => nil})
      patron.save()
      expect(Patron.all()).to(eq([patron]))
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

describe(".find")do
  it("returns a patron by patron ID") do
    test_patron = Patron.new({:name => "betty", :id => nil})
    test_patron.save()
    test_patron2 = Patron.new({:name => "girl stuff", :id => nil})
    test_patron2.save()
    expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
  end
end

describe("#books") do
      it("returns an array of bookss for that patron") do
        test_patron = Patron.new({:name => "betty", :id => nil})
        test_patron.save()
        test_book = Book.new({:title => "true colors", :author => "pau", :patron_id => test_patron.id()})
        test_book.save()
        test_book2 = Book.new({:title => "true colors", :author => "pau", :patron_id => test_patron.id()})
        test_book2.save()
        expect(test_patron.books()).to(eq([test_book, test_book2]))
      end
    end

end
