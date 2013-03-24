require 'spec_helper'

describe "matches/show.html.erb" do
  before(:each) do
    @match = FactoryGirl.create(:flamengo_vs_vasco)
    @moves = [FactoryGirl.create(:flamengo_vs_vasco_move_2, match: @match), FactoryGirl.create(:flamengo_vs_vasco_move_1, match: @match)]
  end

  it "should show the match score" do
    render
    assert_template partial: "matches/match_score", locals: { match: @match }, count: 1
  end

  it "should show the move of match" do
    render
    @moves.each do |move|
      assert_select "div.move#move_#{move.id}" do
        assert_select 'div.time' do
          assert_select 'span', text: move.minute
        end
        assert_select 'div.move_content' do
          assert_select 'span.team', text: move.team_name
          assert_select 'span.move', text: move.text
        end
      end
    end
  end

end