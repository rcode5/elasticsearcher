namespace :es do

  desc 'reindex models'
  task reindex: [:environment] do
    [Post, Author].each do |model|
      puts "Elasticsearch import for #{model.name}"
      model.import force: true, refresh: true
    end
  end

end
