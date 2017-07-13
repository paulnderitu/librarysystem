require("spec_helper")

describe(Book)do
  describe(".all")do
    it("is empty at first")do
      expect(Book.all()).to(eq([]))
    end
  end

describe("#save")do
  it("saves a new book")do
    test_book = Book.new({:title => "true colors", :author => "pau", :patron_id => 1})
    test_book.save()
    expect(Book.all()).to(eq([test_book]))
  end
end

describe("#title") do
      it("lets you read the title out") do
        test_book = Book.new({:title => "true colors", :author => "pau", :patron_id => 1})
        expect(test_book.title()).to(eq("true colors"))
      end
    end

    describe("#author") do
      it("lets you read the book author out") do
        test_book = Book.new({:title => "true colors", :author => "pau", :patron_id => 1})
        expect(test_book.author()).to(eq("pau"))
      end
    end

    describe("#patron_id")do
      it("lets you read the patron_id")do
        test_book = Book.new({:title => "true colors", :author => "pau", :patron_id => 1})
        expect(test_book.patron_id()).to(eq(1))
      end
    end

describe("#==") do
  it("is the same book is has same title, author and patron ID")do
    book1 = Book.new({:title => "true colors", :author => "pau", :patron_id => 1})
    book2 = Book.new({:title => "true colors", :author => "pau", :patron_id => 1})
    expect(book1).to(eq(book2))
  end
  end
end
