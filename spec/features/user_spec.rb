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

  describe "Show a user" do

    it "should redirect if a user doesn't exist" do
      visit user_path(id: 100)
      expect(page.current_url).to eq(root_url)
      expect(page).to have_content('User could not be found')
    end

  end

end
