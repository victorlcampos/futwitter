require 'spec_helper'

describe Tweet do
  context 'relationships' do
    it { should belong_to(:team) }
  end

  describe '.create_using_real_tweet(tweet, team)' do
    let(:tweet) do
      tweet = {}
      tweet.stub(:text) { 'Ola mundo' }
      tweet.stub(:geo)  { '-192 +193' }
      tweet
    end

    before(:each) do
      # Time.stub_chain(:zone, :now) { Time.new(2013, 1, 1, 1, 1, 1) }
    end

    let(:team) do
      team = FactoryGirl.create(:flamengo)
      team.stub(:current_match_start_time) { Time.zone.now + 2.4.minutes }
      team
    end

    subject { Tweet.create_using_real_tweet(tweet, team) }

    its(:team)   { should eq(team) }
    its(:text)   { should eq(tweet.text) }
    its(:geo)    { should eq(tweet.geo) }
    its(:minute) { should eq(-2) }
  end
end
