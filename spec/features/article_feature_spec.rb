require 'spec_helper'

feature 'Article' do
  describe 'new article' do
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit new_article_path
        expect(page).not_to have_content('New article')
        expect(page).to have_content('Email')
      end
    end
    
    context 'user is logged in' do
      before { log_in create(:user) }
      
      context 'with invalid fields' do
        scenario 'shows errors' do
          visit new_article_path
          fill_in 'Text', with: Faker::Lorem.paragraph
          click_on 'Create Article'
          expect(page).to have_content("Title can't be blank")
          fill_in 'Title', with: 'Abc'
          click_on 'Create Article'
          expect(page).to have_content ('Title is too short (minimum is 5 characters)')
        end
      end
      
      context 'with valid fields' do
        scenario 'creates the article' do
          visit new_article_path
          fill_in 'Title', with: 'Exciting News'
          fill_in 'Text', with: 'Some news happened this week and it was splendid.'
          click_on 'Create Article'
          expect(page).to have_content('Exciting News')
          expect(page).to have_content('Some news happened this week and it was splendid.')
        end
      end
    end
  end

  describe 'edit article' do
    let!(:owner) { create :user }
    let!(:article) { create :article, title: 'Exciting News', user: owner }
    
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit edit_article_path(article)
        expect(page).not_to have_content('Edit article')
        expect(page).to have_content('Email')
      end
    end
    
    context 'non-article owner is logged in' do
      before { log_in create(:user) }
      
      scenario 'shows error message' do
        visit edit_article_path(article)
        expect(page).not_to have_content('Edit article')
        expect(page).to have_content('You may not access that article.')
      end
    end
    
    context 'article owner is logged in' do
      before { log_in owner }
      
      context 'with invalid fields' do
        scenario 'shows errors' do
          visit edit_article_path(article)
          fill_in 'Title', with: ''
          click_on 'Update Article'
          expect(page).to have_content("Title can't be blank")
          fill_in 'Title', with: 'Abc'
          click_on 'Update Article'
          expect(page).to have_content ('Title is too short (minimum is 5 characters)')
        end
      end
      
      context 'with valid fields' do
        scenario 'updates the article' do
          visit edit_article_path(article)
          fill_in 'Title', with: 'Stupendous News'
          click_on 'Update Article'
          expect(page).to have_content('Stupendous News')
          expect(page).not_to have_content('Exciting News')
        end
      end
    end
  end

  describe 'destroy article' do
    let!(:owner) { create :user }
    let!(:article) { create :article, title: 'Exciting News', user: owner }
    
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        delete_request article_path(article)
        expect(page).to have_content('Email')
      end
    end
    
    context 'non-article owner is logged in' do
      before { log_in create(:user) }
      
      scenario 'shows error message' do
        delete_request article_path(article)
        expect(page).to have_content('You may not access that article.')
      end
    end
    
    context 'article owner is logged in' do
      before { log_in owner }

      scenario 'destroys the article' do
        visit articles_path
        click_on 'Destroy'
        expect(page).not_to have_content('Exciting News')
      end
    end
  end

  describe 'show article' do
    let!(:article) { create :article, title: 'Writing Tests for Rails' }

    scenario 'shows the article' do
      visit articles_path
      click_on 'Show'
      expect(page).to have_content('Writing Tests for Rails')
    end
  end
end