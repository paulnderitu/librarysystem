require('capybara/rspec')
require('spec_helper')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new patron', {:type => :feature})do
  it('allows the administrator to click a patron and see books and details for it')do
    visit('/')
    # click_link('Add New Patron')
    fill_in('Patron Name', :with => 'betty')
    click_button('Add patron')
    expect(page).to have_content('Welcome to the To the Library System')
  end
end

describe('viewing all the patrons', {:type => :feature})do
  it ('allows an administrator to see all the patrons that have been created')do
    patron = Patron.new({:name => 'betty', :id =>nil})
    patron.save()
    visit('/')
    # click_link('View All Patrons')
    expect(page).to have_content(patron.name)
  end
end
describe('seeing details for a single patron', {:type => :feature})do
  it ('allows an administrator to click a patron to see the books and details for it') do
    test_patron = Patron.new({:name => "sherry", :id => nil})
    test_patron.save()
    test_book = Book.new({:title => "true colors", :author => "pau", :patron_id => test_patron.id()})
    test_book.save()
    visit('/')
    click_link(test_patron.name())
    expect(page).to have_content(test_book.title)
  end
end

  describe('adding books to a patron', {:type => :feature}) do
    it('allows an administrator to add a book to a patron') do
      test_patron = Patron.new({:name => 'sherry', :id => nil})
      test_patron.save()
      visit('/')
      fill_in("Title of the book", {:with => "true colors"})
      fill_in("Author of the book", {:with => "pau"})
      click_button("Add book")
      expect(page).to have_content("Books")
    end
  end
