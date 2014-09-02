module Features
  module SessionHelpers
    def log_in(user = create!(:user))
      visit login_path

      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'
      click_on 'Log In'
    end

    def delete_request(path)
      page.driver.submit :delete, path, {}
    end
  end
end