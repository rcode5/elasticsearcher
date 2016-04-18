require 'rails_helper'

feature "Root", elasticsearch: true, js: true  do

  background do
    create_list :post, 2
    create_list :author, 2

    Author.import refresh: true, force: true
    Post.import refresh: true, force: true

    visit root_path
  end

  scenario "/ should include the application name in its title" do
    expect(page).to have_title "Elasticsearchr"
  end

  scenario "I can see posts" do
    expect(page).to have_css '.posts .table tbody tr', count: 2
  end

  scenario "I can see authors" do
    expect(page).to have_css '.posts .table tbody tr', count: 2
  end

  scenario "I can query a post", js: true do
    click_on "Post | Author"
    common_term = histogram_of(Post, :body).sort_by(&:last).last.first
    within ".search-widget-for-posts" do
      fill_in "query", with: common_term
      click_on "search"
    end
    within '#js-posts-or-authors-search-results' do
      expect(page).to have_content "Searching Post with"
      expect(page).to have_content common_term
      expect(page).to have_css 'tr.search-result'
    end
  end

  scenario "I can query a author", js: true do
    click_on "Post | Author"
    common_term = histogram_of(Author, :name).sort_by(&:last).last.first
    within ".search-widget-for-authors" do
      fill_in "query", with: common_term
      click_on "search"
    end
    within '#js-posts-or-authors-search-results' do
      expect(page).to have_content "Searching Author with"
      expect(page).to have_content common_term
      expect(page).to have_css 'tr.search-result'
    end
  end

end
