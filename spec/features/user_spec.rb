require 'rails_helper'

RSpec.feature 'Users:', type: :feature do

  describe 'Creating a user' do

    before do
      expect(ActionMailer::Base.deliveries.empty?).to be true
      visit '/'
      click_on 'New User'
      fill_in 'Name', with: 'Sam Smith'
      fill_in 'Email', with: 'sam@email.com'
      click_on 'Create User'
    end

    it 'notifies an admin by email' do
      email = ActionMailer::Base.deliveries.last
      expect(email.subject).to eq 'New user added'
      expect(email.to_s).to include 'Sam Smith'
    end

  end

  describe "Updating a user" do

    before do
      user = User.create name: "User 1", email: "an@email.com"
      visit edit_user_path(user)
    end

    it "should update user with new name" do
      fill_in 'Name', with: 'Sam Smith 123'
      click_on 'Update User'

      expect(page).to have_content("Sam Smith 123")
    end

    it "should update user with new email" do
      fill_in 'Email', with: 'sam123@email.com'
      click_on 'Update User'

      expect(page).to have_content("sam123@email.com")
    end

  end

  describe "Validating required fields" do

    before do
      visit root_url
      click_on 'New User'
    end

    it "should fail due to not entering a name" do
      fill_in 'Email', with: 'sam@email.com'
      click_on 'Create User'

      expect(page).to have_content("can't be blank")
    end

    it "should fail due to not entering an email" do
      fill_in 'Name', with: 'Sam Smith'
      click_on 'Create User'

      expect(page).to have_content("is invalid")
    end

    it "should fail due to not entering the correct format for a email" do
      fill_in 'Email', with: 'samemail.com'
      click_on 'Create User'

      expect(page).to have_content("is invalid")
    end

  end

  describe "Show a user" do

    it "should redirect if a user doesn't exist" do
      visit user_path(id: 100)
      expect(page.current_url).to eq(root_url)
      expect(page).to have_content('User could not be found')
    end

  end

end
