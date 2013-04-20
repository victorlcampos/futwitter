require 'spec_helper'

describe 'matches/_match_score.html.erb' do
  before(:each) do
    @match = FactoryGirl.create(:flamengo_vs_vasco)
  end

  it 'show the match score' do
    render partial: 'matches/match_score', locals: { match: @match }
    match = @match

    assert_select "a.match#match_#{match.id}[href='#{match_path(match)}']" do
      assert_select 'div.home_team' do
        badge_url = match.home_team_badge_url
        assert_select "span.team_badge > img[src='#{badge_url}']"
        assert_select 'span.team_name',  text: match.home_team_name
        assert_select 'span.team_score', text: match.home_team_score
      end

      assert_select 'span.vs', text: 'x'

      assert_select 'div.away_team' do
        badge_url = match.away_team_badge_url
        assert_select 'span.team_score', text: match.away_team_score
        assert_select 'span.team_name',  text: match.away_team_name
        assert_select "span.team_badge > img[src='#{badge_url}']"
      end
    end
  end

end