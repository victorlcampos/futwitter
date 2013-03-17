require 'spec_helper'

describe "matches/show.html.erb" do
  before(:each) do
    @match = FactoryGirl.create(:flamengo_vs_vasco)
  end

  it "should show the match score" do
    render
    assert_template partial: "matches/match_score", locals: { match: @match }, count: 1
  end

end