require 'spec_helper'

feature 'Auth' do
  describe 'login' do
    let!(:user) { create :user }

    context 'user fills in invalid credentials' do
      scenario 'shows error' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'notpassword'
        click_on 'Log In'
        expect(page).to have_content('Invalid credentials; please try again')
      end
    end
    
    context 'user fills in valid username and password' do
      scenario 'logs in the user' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        click_on 'Log In'
        expect(page).to have_content('Logged in!')
      end
    end
  end

  describe 'logout' do
    let!(:user) { create :user }
    
    before { log_in user }
    
    context 'user clicks logout link' do
      scenario 'logs out the user' do
        click_on 'Sign Out'
        expect(page).to have_content('Sign In')
        expect(page).not_to have_content('Sign Out')
      end
    end
  end

  describe 'create user' do
    let!(:existing_user) { create :user, email: 'john@doe.com' }

    context 'user supplies a duplicate email' do
      scenario 'shows error' do
        visit new_user_path
        fill_in 'Email', with: 'john@doe.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Create User'
        expect(page).to have_content('Email has already been taken')
      end
    end

    context 'user fills in invalid information' do
      scenario 'shows error' do
        visit new_user_path
        fill_in 'Email', with: 'jane@doe.com'
        click_on 'Create User'
        expect(page).to have_content("Password can't be blank")
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'notpassword'
        click_on 'Create User'
        expect(page).to have_content("Password confirmation doesn't match Password")
      end
    end

    context 'user fills in valid information' do
      scenario 'creates the user' do
        visit new_user_path
        fill_in 'Email', with: 'jane@doe.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Create User'
        expect(page).to have_content('Registered! Please log in.')
      end
    end
  end
end