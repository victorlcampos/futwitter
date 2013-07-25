# encoding: utf-8
require 'spec_helper'

describe Match do
  let!(:start_time) { Time.zone.now }

  context 'relationships' do
    it { should belong_to(:home_team).class_name('Team') }
    it { should belong_to(:away_team).class_name('Team') }
    it { should belong_to(:championship) }
    it { should have_many(:moves) }
  end

  subject(:flamengo_vs_vasco) do
    params = {
      start_time: start_time
    }
    flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco, params)
    Match.find(flamengo_vs_vasco.id)
  end

  its(:end_time)  { should eq(subject.start_time + 2.hours) }
  its(:open_time) { should eq(subject.start_time - 30.minutes)}
  its(:close_time) { should eq(subject.end_time + 30.minutes)}
  its(:home_team_tweets) { should eq(subject.home_team.match_tweets(subject)) }
  its(:away_team_tweets) { should eq(subject.away_team.match_tweets(subject)) }
  its(:home_team_tweets_count) do
    subject.stub_chain(:home_team_tweets, :count) { 5 }
    should eq(5)
  end
  its(:away_team_tweets_count) do
    subject.stub_chain(:away_team_tweets, :count) { 1 }
    should eq(1)
  end

  its(:geo_home_team_tweets) do
    should eq(subject.home_team_tweets.where(geo: true))
  end
  its(:geo_away_team_tweets) do
    should eq(subject.away_team_tweets.where(geo: true))
  end

  context 'delegated mathods' do
    its(:home_team_name) { should eq('Flamengo') }
    its(:away_team_name) { should eq('Vasco') }
    its(:championship_name) { should eq('Campeonato carioca') }

    its(:home_team_badge_url) do
      should eq(flamengo_vs_vasco.home_team.badge_url)
    end

    its(:away_team_badge_url) do
      should eq(flamengo_vs_vasco.away_team.badge_url)
    end
  end

  context 'running game' do
    before(:each) do
      Time.zone.stub(:now) { start_time - 27.minutes }
      subject.stub_chain(:home_team_tweets, :count) { 5 }
      subject.stub_chain(:away_team_tweets, :count) { 1 }
    end
    its(:home_tweets_per_minute) { should eq(2) }
    its(:away_tweets_per_minute) { should eq(0) }
  end

  context 'ended game' do
    before(:each) do
      Time.zone.stub(:now) { start_time + 10.hours  }
      subject.stub_chain(:home_team_tweets, :count) { 180 * 2 }
      subject.stub_chain(:away_team_tweets, :count) { 180     }
    end

    its(:home_tweets_per_minute) { should eq(2) }
    its(:away_tweets_per_minute) { should eq(1) }
  end
end