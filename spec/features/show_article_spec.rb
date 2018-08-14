require 'rails_helper'

RSpec.feature "Showing an article" do

  before do
    @john = User.create!(email: 'john@email.com', password: 'password')
    @fred = User.create!(email: 'fred@email.com', password: 'password')
    @article = Article.create(title: "Title New", body: "Body of article one", user: @john)
  end

  scenario "To non-signed in user hide the Edit and Delete buttons" do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario "To non-owner in user hide the Edit and Delete buttons" do
    login_as(@fred)
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end
end