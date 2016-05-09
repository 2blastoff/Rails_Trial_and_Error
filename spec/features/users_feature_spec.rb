require 'rails_helper'

feature 'users' do

  before do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      click_link 'Add a contact'
      fill_in 'Firstname', with: 'John'
      fill_in 'Surname', with: 'Jones'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Phone', with: '223344'
      attach_file('contact[image]', Rails.root + 'spec/mouse1.jpeg')
      click_button 'Create Contact'
      click_link 'Add a contact'
      fill_in 'Firstname', with: 'bill'
      fill_in 'Surname', with: 'withers'
      fill_in 'Email', with: 'testy@testy.com'
      fill_in 'Phone', with: '654321'
      attach_file('contact[image]', Rails.root + 'spec/lion1.jpg')
      click_button 'Create Contact'
      click_link 'Log out'

      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'test3@test3.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      click_link 'Log out'
  end

  context 'user sees only their contacts' do
    scenario 'upon loggin in' do
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content 'Log out John Jones test@test.com 223344 bill withers testy@testy.com 654321 Add a contact'
    end
  end

  context ''do
    scenario ''do
      fill_in 'Email', with: 'test3@test3.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content 'No contacts yet!'
      expect(page).to have_link 'Log out'
      expect(page).to have_link 'Add a contact'
      expect(current_path).to eq('/')
    end
  end



end
