require 'rails_helper'

RSpec.feature 'Books:', type: :feature do

  let(:user) { User.create name: "User 1", email: "an@email.com" }

  describe 'Adding a book' do

    before do
      user
      visit user_path(user)
      fill_in 'Title', with: 'My new book'
      click_on 'Save Book'
    end

    it 'displays the book title on the user show page' do
      expect(page).to have_content('My new book')
    end

  end

  describe 'Deleting a book' do

    let(:book) { Book.create title: 'Wonderful book', user: user }

    before do
      book
      visit user_path(user)
    end

    it 'displays the book title on the user show page' do
      expect(page).to have_content('Wonderful book')
      click_on 'Destroy'
      expect(page).to_not have_content('Wonderful book')
    end

  end

end
