require 'rails_helper'

describe Search::Result do

  let(:es_hit) {
    {
      "_index" => "posts",
      "_type" => "post",
      "_id" => "4",
      "_score"  => 0.184,
      "_source" => {
        "id":4,
        "title" => "san francisco is the town where we live",
        "body" => "and that's cuz it is joe mony",
        "created_at" => "2016-02-01T21:39:51.255Z",
        "updated_at" => "2016-02-02T19:19:59.956Z"
      },
      "highlight" => {
        "title" => ["the highlighted title"]
      }
    }
  }
  subject(:hit) { described_class.new(es_hit) }

  its(:score) { is_expected.to eql 0.184 }
  its(:type) { is_expected.to eql 'post' }
  its(:source) { is_expected.to be_a_kind_of Hash }
  its(:id) { is_expected.to eql 4 }
  its(:title) { is_expected.to eql "the highlighted title" }
end
