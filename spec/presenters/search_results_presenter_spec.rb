require 'rails_helper'

describe SearchResultsPresenter do

  let(:results) {
    [
      Search::Result.new( { "_type" => 'model1' } ),
      Search::Result.new( { "_type" => 'model2' } ),
      Search::Result.new( { "_type" => 'model1' } ),
    ]
  }

  subject(:presenter) { described_class.new(results) }

  describe "#present?" do
    it "returns true when there are results" do
      expect(presenter).to be_present
    end

    it "returns false when there are no results" do
      expect(described_class.new([])).not_to be_present
    end
  end

  describe "#by_type" do

    it "returns results organized by their model type" do
      expect(subject.by_type.keys).to eql ['model1', 'model2']
      expect(subject.by_type['model1']).to have(2).results
      expect(subject.by_type['model2']).to have(1).result
    end

    it "returns results as arrays of Search::ResultsPresenters" do
      expect(subject.by_type.values.flatten.all? { |v| v.is_a? SearchResultPresenter }).to eql true
    end

  end

end
