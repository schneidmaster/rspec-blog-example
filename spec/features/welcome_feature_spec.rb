require 'spec_helper'

feature 'Welcome' do
  scenario 'welcomes the user' do
    visit root_path
    expect(page).to have_content('Hello, Rails!')
  end
end