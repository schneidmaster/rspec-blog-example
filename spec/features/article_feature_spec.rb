require 'spec_helper'

feature 'Article' do
  describe 'show article' do
    let!(:article) { create :article, title: 'Writing Tests for Rails' }

    scenario 'shows the article' do
      visit articles_path
      click_on 'Show'
      expect(page).to have_content('Writing Tests for Rails')
    end
  end
end