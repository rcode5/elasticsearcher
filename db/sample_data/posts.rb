posts = [
  {
    title: "How to Stretch Elasticsearch",
    body: "Do it the right way."
  },
  {
    title: "How to Make Mashed Potatoes",
    body: "Mush it the wrong way."
  },
  {
    title: "How to deal with stems, stemmers, and stemming",
    body: "Make prefixes of the words for better wording and use the word."
  }
]

posts.each do |post|
  Post.create_with(post).find_or_create_by(post.slice(:title))
end
