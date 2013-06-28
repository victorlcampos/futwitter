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

  its(:end_time) { should eq(subject.start_time + 2.hours) }

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

    its(:home_team_tweets_count) do
      should eq(flamengo_vs_vasco.home_team.tweets_count)
    end

    its(:away_team_tweets_count) do
      should eq(flamengo_vs_vasco.away_team.tweets_count)
    end
  end

  describe 'running game' do
    before(:each) do
      Time.zone.stub(:now) { start_time - 27.minutes }
      subject.home_team.stub(:tweets_count) { 5 }
      subject.away_team.stub(:tweets_count) { 1 }
    end
    its(:home_tweets_per_minute) { should eq(2) }
    its(:away_tweets_per_minute) { should eq(0) }
  end

  describe 'ended game' do
    before(:each) do
      Time.zone.stub(:now) { start_time + 10.hours  }
      subject.home_team.stub(:tweets_count) { 180 * 2 } # 2 tweets per minute
      subject.away_team.stub(:tweets_count) { 180     } # 1 tweets per minute
    end

    its(:home_tweets_per_minute) { should eq(2) }
    its(:away_tweets_per_minute) { should eq(1) }
  end
end