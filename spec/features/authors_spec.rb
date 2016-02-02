require 'rails_helper'

feature "Authors", elasticsearch: true, js: true do

  background do
    visit root_path
  end

  scenario "I can create an author" do
    click_on "New Author"
    author = attributes_for :author
    fill_in "Name", with: author[:name]
    fill_in "Hometown", with: author[:hometown]
    click_on "Create Author"
    expect(page).to have_content author[:name]
    expect(page).to have_content author[:hometown]
    expect(page).to have_flash :info, "I love new stuff"
    click_on "Back"
    expect(current_path).to eql root_path
  end

end
