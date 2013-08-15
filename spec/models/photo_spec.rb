require 'spec_helper'

describe Photo do
  context 'relationships' do
    it { should belong_to(:team) }
    it { should belong_to(:match) }
  end

  context 'creating' do
    describe 'create_by_tweet' do
      let!(:tweet) do
        tweet = {}
        media = {}
        media.stub(:media_url) { 'http://media_url.jpg' }

        tweet.stub(:text) { 'Ola MUNDOOOO' }
        tweet.stub(:media) { [media] }
        tweet
      end

      let!(:team) do
        team = FactoryGirl.create(:flamengo)
        match = FactoryGirl.create(:flamengo_vs_vasco)
        team.stub(:current_match) { match }
        team
      end

      before(:each) do
        Photo.create_by_tweet(tweet, team)
      end

      context 'new media' do
        it 'should save new Photo' do
          Photo.count.should eq(1)
        end

        it "should save description" do
          Photo.first.description.should eq(tweet.text)
        end

        it "should save team" do
          Photo.first.team_id.should eq(team.id)
        end

        it "should save match" do
          Photo.first.match.should eq(team.current_match)
        end

        it "should save url" do
          Photo.first.url.should eq('http://media_url.jpg')
        end
      end

      context 'old media' do
        before(:each) do
          Photo.create_by_tweet(tweet, team)
        end

        it 'should save new Photo' do
          Photo.count.should eq(1)
        end
      end
    end
  end
end
