require 'rails_helper'

feature "Elasticsearch" do

  scenario "is available", elasticsearch: true do
    es_response = `curl http://localhost:#{TestEsServer.port}/`
    expect(JSON.parse(es_response)['tagline']).to match /you know, for search/i
  end

end
