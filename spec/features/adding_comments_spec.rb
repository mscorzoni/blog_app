require 'rails_helper'

RSpec.feature 'Adding Reviews to Articles' do
  before do
    @john = User.create!(email: 'john@email.com', password: 'password')
    @fred = User.create!(email: 'fred@email.com', password: 'password')
    @article = Article.create(title: "Title New", body: "Body of article one", user: @john)
  end

  scenario "permits a signed user to write a review" do
    login_as(@fred)
    visit "/"

    click_link @article.title
    fill_in 'New Comment', with: "test comment"
    click_button 'Add Comment'

    expect(page).to have_content('Comment has been created')
    expect(page).to have_content('test comment')
    expect(current_path).to eq article_path(@article.id)
  end
end