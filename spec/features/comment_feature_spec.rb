require 'spec_helper'

feature 'Comment' do
  let!(:article) { create :article, title: 'Exciting News' }

  describe 'new comment' do
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit article_path(article)
        fill_in 'Commenter', with: 'John Doe'
        fill_in 'Body', with: 'These are my remarks'
        click_on 'Create Comment'
        expect(page).not_to have_content('These are my remarks')
        expect(page).to have_content('Email')
      end
    end
    
    context 'user is logged in' do
      before { log_in create(:user) }
      
      context 'with valid fields' do
        scenario 'creates the comment' do
          visit article_path(article)
          fill_in 'Commenter', with: 'John Doe'
          fill_in 'Body', with: 'These are my remarks'
          click_on 'Create Comment'
          expect(page).to have_content('John Doe')
          expect(page).to have_content('These are my remarks')
        end
      end
    end
  end

  describe 'destroy comment' do
    let!(:owner) { create :user }
    let!(:comment) { create :comment, body: 'These are my remarks', article: article, user: owner }

    context 'user is not logged in' do
      scenario 'redirects to login path' do
        delete_request article_comment_path(article, comment)
        expect(page).to have_content('Email')
      end
    end
    
    context 'non-comment owner is logged in' do
      before { log_in create(:user) }
      
      scenario 'shows error message' do
        delete_request article_comment_path(article, comment)
        expect(page).to have_content('You may not access that comment.')
      end
    end
    
    context 'comment owner is logged in' do
      before { log_in owner }

      scenario 'destroys the comment' do
        visit article_path(article)
        click_on 'Destroy'
        expect(page).not_to have_content('These are my remarks')
      end
    end
  end
end