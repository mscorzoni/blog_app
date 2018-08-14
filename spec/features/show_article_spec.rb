require 'rails_helper'

RSpec.feature "Showing an article" do

  before do
    john = User.create!(email: 'john@email.com', password: 'password')
    login_as(john)
    @article = Article.create(title: "Title New", body: "Body of article one", user: john)
  end

  scenario "A user shows an article" do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
  
end