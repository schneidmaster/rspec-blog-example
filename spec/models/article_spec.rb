require 'spec_helper'

describe Article do
  describe '#preview' do
    context "article's text is less than 300 characters" do
      subject { create :article, title: 'Exciting News', text: 'This is rather short.' }

      it "returns the article's entire text" do
        expect(subject.preview).to eq('This is rather short.')
      end
    end

    context "article's text is >25 characters and the 22nd character divides a word" do
      subject { create :article, title: 'Exciting News', text: 'This article is somewhat longer and "somewhat" will be split.' }

      it 'truncates the article at the last word and appends ellipsis' do
        expect(subject.preview).to eq('This article is...')
      end
    end

    context "article's text is >25 characters and the 22nd character completes a word" do
      subject { create :article, title: 'Exciting News', text: 'This article is longer so it will end after "longer"' }

      it 'truncates the article and appends ellipsis' do
        expect(subject.preview).to eq('This article is longer...')
      end
    end

    context "article's text is >25 characters and the 22nd character is a space after a word" do
      subject { create :article, title: 'Exciting News', text: 'This article is kinda long and will end at "kinda"' }

      it 'truncates the article, removes the space, and appends ellipsis' do
        expect(subject.preview).to eq('This article is kinda...')
      end
    end
  end
end