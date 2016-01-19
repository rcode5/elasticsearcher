authors = [
  {
    name: "Joe Muster",
    hometown: "San Francisco"
  },
  {
    name: "Jill Jackson",
    hometown: "Boston"
  },
  {
    name: "Joey Moey",
    hometown: "Jacksonville"
  }
]

authors.each do |author|
  Author.create_with(author).find_or_create_by(author.slice(:name))
end
