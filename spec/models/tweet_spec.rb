require 'spec_helper'

describe Tweet do
  context 'relationships' do
    it { should belong_to(:team) }
  end

  context 'delegated_methods' do
    let(:team) { FactoryGirl.create(:flamengo) }
    subject { FactoryGirl.create(:tweet, team: team) }
    its(:team_name) { should eq(team.name) }
  end

  context 'scopes' do
    describe 'geo' do
      let!(:tweet1) { FactoryGirl.create(:tweet, geo: true) }
      let!(:tweet2) { FactoryGirl.create(:tweet, geo: false) }

      it 'should return all geo tweets' do
        Tweet.geo.should eq([tweet1])
      end
    end
    describe 'match_tweets' do
      let!(:match) do
        start_time = Time.zone.now
        params = {
          start_time: start_time
        }
        flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco, params)
        Match.find(flamengo_vs_vasco.id)
      end

      let!(:tweet1) do
        params = {
          created_at: match.open_time - 10.minutes
        }
        FactoryGirl.create(:tweet, params)
      end
      let!(:tweet2) do
        params = {
          team: match.home_team,
          created_at: match.open_time
        }
        FactoryGirl.create(:tweet, params)
      end
      let!(:tweet3) do
        params = {
          team: match.home_team,
          created_at: match.open_time + 30.minutes
        }
        FactoryGirl.create(:tweet, params)
      end
      let!(:tweet4) do
        params = {
          team: match.home_team,
          created_at: match.close_time
        }
        FactoryGirl.create(:tweet, params)
      end
      let!(:tweet5) do
        params = {
          team: match.home_team,
          created_at: match.close_time + 30.minutes
        }
        FactoryGirl.create(:tweet, params)
      end

      it 'should return tweets in this match' do
        Tweet.match_tweets(match).should eq([tweet2, tweet3, tweet4])
      end
    end
  end

  describe '.create_using_real_tweet(tweet, team)' do
    let(:tweet) do
      tweet = {}
      tweet.stub(:text) { 'Ola mundo' }
      tweet.stub(:geo) { nil }
      tweet
    end

    let(:team) do
      team = FactoryGirl.create(:flamengo)
      team.stub(:current_match_start_time) { Time.zone.now + 2.4.minutes }
      team
    end

    subject { Tweet.create_using_real_tweet(tweet, team) }

    its(:team)      { should eq(team) }
    its(:text)      { should eq(tweet.text) }
    its(:minute)    { should eq(-2) }

    context 'with geo' do
      before(:each) do
        tweet.stub_chain(:geo)   { true }
        tweet.stub_chain(:geo, :latitude)   { -192.23 }
        tweet.stub_chain(:geo, :longitude)  { 192.25 }
      end
      its(:geo)       { should eq(true) }
      its(:latitude)  { should eq(tweet.geo.latitude) }
      its(:longitude) { should eq(tweet.geo.longitude) }
    end

    context 'without geo' do
      its(:geo)       { should eq(false) }
      its(:latitude)  { should eq(nil) }
      its(:longitude) { should eq(nil) }
    end
  end
end
