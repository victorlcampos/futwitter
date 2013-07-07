require 'spec_helper'

describe 'matches/show.html.erb' do
  let!(:start_time) { Time.zone.now }
  before(:each) do
    match = FactoryGirl.create(:flamengo_vs_vasco, start_time: start_time)

    flamengo_vs_vasco_move_2 = FactoryGirl.create(:flamengo_vs_vasco_move_2,
                                                   match: match)

    flamengo_vs_vasco_move_1 = FactoryGirl.create(:flamengo_vs_vasco_move_1,
                                                   match: match)

    FactoryGirl.create(:tweet, team: match.home_team)
    FactoryGirl.create(:tweet, team: match.home_team)
    FactoryGirl.create(:tweet, team: match.home_team)
    FactoryGirl.create(:tweet, team: match.away_team)


    match = Match.find(match.id)
    @presenter = MatchesShowPresenter.new(match)
  end

  it 'should show the match score' do
    render
    assert_template partial: 'matches/match_score',
                    locals: { match: @presenter.match }, count: 1
  end

  it 'should show the move of match' do
    render
    @presenter.moves.each do |move|
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

  it 'should show the total home tweets' do
    render
    assert_select '.total_home_tweets', text: 3
  end

  it 'should show the total home tweets' do
    render
    assert_select '.total_away_tweets', text: 1
  end

  it 'should show the total home tweets' do
    Time.zone.stub(:now) { start_time - 27.minutes }
    render
    assert_select '.tpm_home', text: 1
  end

  it 'should show the total home tweets' do
    Time.zone.stub(:now) { start_time - 27.minutes }
    render
    assert_select '.tpm_home', text: 0
  end

  it 'should show tweets tweets_during_the_minutes' do
    render
    assert_select '#tweets_during_the_minutes'
  end

  it 'should show tweets world_map' do
    render
    assert_select '#world_map'
  end
end