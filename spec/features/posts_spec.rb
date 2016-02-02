require 'rails_helper'

feature "Posts" do

  background do
    visit root_path
  end

  scenario "I can create an post" do
    click_on "New Post"
    post = attributes_for :post
    fill_in "Title", with: post[:title]
    fill_in "Body", with: post[:body]
    click_on "Create Post"
    expect(page).to have_content post[:title]
    expect(page).to have_content post[:body]
    expect(page).to have_flash :info, "Your site is growing"
    click_on "Back"
    expect(current_path).to eql root_path
  end

end
