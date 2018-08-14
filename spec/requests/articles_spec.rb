require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @john = User.create!(email: 'john@email.com', password: 'password')
    @fred = User.create!(email: 'fred@email.com', password: 'password')
    @article = Article.create!(title: "My first article", body: "Some text", user: @john)
  end

  describe 'GET /articles/:id' do
    context 'with non signed in user' do
      before { get "/articles/#{@article.id}/edit" }

      it 'redirects to the sign in page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user non owner' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end 

      it 'redirects to homepage' do
        expect(response.status).to eq 302
        flash_message = 'You can only edit your own article.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user and owner successfully edit' do
      before do
        login_as(@john)
        get "/articles/#{@article.id}/edit"
      end 

      it 'successfully edits an article' do
        expect(response.status).to eq 200
      end
    end
  end


  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it 'handles  existing article' do
        expect(response.status).to eq 200
      end
  end

    context 'while non-existing article' do
      before do
        get '/articles/xxxxx'
      end

      it 'handles non-existing article' do
        expect(response.status).to eq 302
        flash_message = 'The article you are looking for could not be found'
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end