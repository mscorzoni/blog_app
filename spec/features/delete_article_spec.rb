require 'rails_helper'


RSpec.feature "Deleting an article" do

  before do
    john = User.create!(email: 'john@email.com', password: 'password')
    login_as(john)
    @article = Article.create(title: "Title New", body: "Body of article one", user: john)
  end

  scenario 'A user delete an article' do
    visit '/'

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content('Article has been deleted')
    expect(current_path).to eq(articles_path)
  end
end