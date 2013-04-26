require 'spec_helper'

describe 'matches/_match_score.html.erb' do

  let!(:match) { FactoryGirl.create(:flamengo_vs_vasco) }

  it 'show the match score' do
    render partial: 'matches/match_score', locals: { match: match }

    a_id = "match_#{match.id}"
    a_attributes = "href='#{match_path(match)}'"
    a_classes = "match.championship_#{match.championship_id}"

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

  describe 'when filter is false' do
    it 'should not add filter class' do
      render partial: 'matches/match_score', locals: { match: match }

      element = "a.match.filter#match_#{match.id}[href='#{match_path(match)}']"
      assert_select element, false
    end
  end

  describe 'when filter is true' do
    it 'should add filter class' do
      locals = { match: match, filter: true }

      render partial: 'matches/match_score', locals: locals

      element = "a.match.filter#match_#{match.id}[href='#{match_path(match)}']"
      assert_select element, true
    end
  end

end