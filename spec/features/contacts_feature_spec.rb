require 'rails_helper'

feature 'no contacts' do

  context 'no contacts have been added' do
    scenario 'should display a prompt to signup at login screen' do
      visit '/'
      expect(page).to have_button 'Log in'
      expect(page).to have_link 'Sign up'
    end
  end

  context 'no contacted added' do
    scenario 'signing up' do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      expect(page).to have_content 'No contacts yet!'
      expect(page).to have_link 'Log out'
      expect(page).to have_link 'Add a contact'
      expect(current_path).to eq('/')
    end
  end
end


feature 'contacts' do

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
  end

  context 'add contact (done in before)' do
    scenario 'should display contacts page with contacts details' do
      expect(page).to have_content 'John Jones test@test.com 223344'
      expect(page).to have_xpath("//img[contains(@src, \/html/body/a[2]/img\)]")
      expect(current_path).to eq ('/contacts')
    end
  end

  context 'view a contact' do
    scenario 'click contact to view details' do
      click_link('Mouse1')
      contact = Contact.find_by(email:  'test@test.com')
      expect(page).to have_content 'John Jones 223344 test@test.com'
      expect(page).to have_xpath("//img[contains(@src, \/html/body/a[2]/img\)]")
      expect(page).to have_current_path(contact_path(contact.id))
      expect(page).to have_link 'Edit'
    end
  end

  context 'edit a contact' do
    scenario 'edit a contacts details' do
      click_link('Mouse1')
      click_link 'Edit'
      fill_in 'Firstname', with: 'cheese'
      fill_in 'Phone', with: '221111'
      click_button 'Update Contact'
      contact = Contact.find_by(email:  'test@test.com')
      expect(page).to have_content 'cheese Jones 221111 test@test.com'
      expect(page).to have_xpath("//img[contains(@src, \/html/body/a[2]/img\)]")
      expect(page).to have_link 'Contacts'
      expect(page).to have_current_path(contact_path(contact.id))
    end
  end

  context 'remove all contacts' do
    scenario 'removed the contact from contacts list' do
      click_link('Mouse1')
      click_link('Remove')
      click_link('Lion1')
      click_link('Remove')
      expect(page).to have_content 'No contacts yet!'
      expect(page).to have_link 'Log out'
      expect(page).to have_link 'Add a contact'
      expect(current_path).to eq('/contacts')
    end
  end







end
