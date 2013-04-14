require 'spec_helper'

describe "home/index.html.erb" do
  before(:each) do
    @matches = assign(:matches, [FactoryGirl.create(:flamengo_vs_vasco), FactoryGirl.create(:fluminense_vs_botafogo)])
  end

  it "should show the matches score list" do
    render

    @matches.each do |match|
      assert_select "a.match#match_#{match.id}[href='#{match_path(match)}']" do
        assert_select "div.home_team" do
          assert_select "span.team_badge > img[src='#{match.home_team_badge_url}']"
          assert_select "span.team_name",  text: match.home_team_name
          assert_select "span.team_score", text: match.home_team_score
        end

        assert_select "span.vs", text: "x"

        assert_select "div.away_team" do
          assert_select "span.team_score", text: match.away_team_score
          assert_select "span.team_name",  text: match.away_team_name
          assert_select "span.team_badge > img[src='#{match.away_team_badge_url}']"
        end
      end
    end
  end

end
