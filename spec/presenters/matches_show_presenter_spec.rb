require 'spec_helper'

describe MatchesShowPresenter do
  let!(:start_time) { Time.zone.now }
  let!(:match) do
    FactoryGirl.create(:flamengo_vs_vasco, start_time: start_time)
  end

  subject { MatchesShowPresenter.new(match) }

  its(:match) { should eq(match) }

  it '#home_team_tweets_count should return match.home_team_tweets_count' do
    match.stub(:home_team_tweets_count) { 3 }
    subject.home_team_tweets_count.should eq(3)
  end

  it '#away_team_tweets_count should return match.away_team_tweets_count' do
    match.stub(:away_team_tweets_count) { 3 }
    subject.away_team_tweets_count.should eq(3)
  end

  it '#moves should return match.moves' do
    move_2 = FactoryGirl.build(:flamengo_vs_vasco_move_2,
                                                   match: match)

    move_1 = FactoryGirl.build(:flamengo_vs_vasco_move_1,
                                                   match: match)
    match.stub(:moves) { [move_2, move_1] }
    subject.moves.should eq([move_2, move_1])
  end

  it '#home_tweets_per_minute should return match.home_tweets_per_minute' do
    match.stub(:home_tweets_per_minute) { 3 }
    subject.home_tweets_per_minute.should eq(3)
  end

  it '#away_tweets_per_minute should return match.away_tweets_per_minute' do
    match.stub(:away_tweets_per_minute) { 3 }
    subject.away_tweets_per_minute.should eq(3)
  end
  it '#home_team_name should return match.home_team_name' do
    subject.home_team_name.should eq(match.home_team_name)
  end

  it '#away_team_name should return match.away_team_name' do
    subject.away_team_name.should eq(match.away_team_name)
  end

  describe '#tweets_during_the_minutes' do
    before(:each) do
      home_team = match.home_team
      away_team = match.away_team
      FactoryGirl.create(:tweet, team: away_team, minute: 3)
      FactoryGirl.create(:tweet, team: away_team, minute: 1)
      FactoryGirl.create(:tweet, team: home_team, minute: 2)
      FactoryGirl.create(:tweet, team: home_team, minute: 1)
      FactoryGirl.create(:tweet, team: home_team, minute: 1)
      match = Match.find(subject.match.id)
    end
    it 'should return tweets group_by minutes' do
      expected_return = [
        [1, {home: 2, away: 1}],
        [2, {home: 1, away: 0}],
        [3, {home: 0, away: 1}]
      ]
      subject.tweets_during_the_minutes.should eq(expected_return)
    end
  end
end