require 'spec_helper'

describe Api::V1::ArticlesController do
  let!(:article1) { create :article, title: 'First Article' }
  let!(:article2) { create :article, title: 'Second Article' }

  describe '#index' do
    subject  { get :index }

    it 'renders a JSON list of articles' do
      expect(JSON.parse(subject.body).length).to eq(2)
      expect(JSON.parse(subject.body)[0]['title']).to eq('First Article')
      expect(JSON.parse(subject.body)[1]['title']).to eq('Second Article')
    end
  end

  describe '#show' do
    subject  { get :show, id: article1.id }

    it 'renders the first article' do
      expect(JSON.parse(subject.body)['title']).to eq('First Article')
    end
  end
end