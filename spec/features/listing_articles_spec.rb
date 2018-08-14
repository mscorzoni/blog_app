require "rails_helper"

RSpec.feature "Listing Articles" do
  before do
    john = User.create!(email: 'john@email.com', password: 'password')
    @article1 = Article.create(title: "Title New", body: "Body of article one", user: john)
    @article2 = Article.create(title: "My 2nd article", body: "Some more text", user: john)
  end

  scenario 'A user lists all articles' do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end


  scenario 'A user has no articles' do
    Article.delete_all

    visit "/"

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end
  end
end