require 'spec_helper'

describe 'home/index.html.erb' do
  before(:each) do
    flamengo_vs_vasco      = FactoryGirl.create(:flamengo_vs_vasco)
    fluminense_vs_botafogo = FactoryGirl.create(:fluminense_vs_botafogo)

    @matches = assign(:matches, [flamengo_vs_vasco, fluminense_vs_botafogo])
  end

  it 'should show the matches score list' do
    render

    @matches.each do |match|
      a_id = "match_#{match.id}"
      a_attributes = "href='#{match_path(match)}'"
      a_classes = "match.filter.championship_#{match.championship_id}"

      assert_select "a.#{a_classes}##{a_id}[#{a_attributes}]" do
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

end
