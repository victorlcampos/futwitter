# encoding: utf-8
require 'spec_helper'

describe News do
  let!(:start_time) { Time.zone.now }

  context 'relationships' do
    it { should belong_to(:team) }
  end

  describe '.create_by_tweet(tweet, team)' do
    let!(:tweet) do
      tweet = {}
      tweet.stub(:urls) { [] }
      tweet.stub(:retweet_count) { 10 }
      tweet.stub(:created_at) { start_time }
      tweet
    end
    let!(:team) { FactoryGirl.create(:flamengo) }

    let!(:url) do
      unshorted_url = File.join(Rails.root, 'spec', 'support', 'urls',
                                                     'news_globoesporte.html')
    end

    context 'new news' do
      context 'tweet with url' do
        before(:each) do
          expanded_url = {}
          expanded_url.stub(:expanded_url) { 'shorted_url.com' }
          tweet.stub(:urls) { [expanded_url] }

          url_with_params = url
          url_with_params << '?utm_term=a'
          url_with_params << '&utm_content=b'
          url_with_params << '&utm_source=c'
          url_with_params << '&utm_medium=d'
          url_with_params << '&utm_campaign=e'

          Unshortme.stub(:unshort).with('shorted_url.com') { url_with_params }
          News.create_by_tweet(tweet, team)
        end

        it 'should save new News' do
          News.count.should eq(1)
        end

        it 'should save shorted_url' do
          News.first.shorted_url.should eq('shorted_url.com')
        end

        it 'should save url' do
          unshorted_url = File.join(Rails.root, 'spec', 'support', 'urls',
                                                     'news_globoesporte.html')
          News.first.url.should eq(unshorted_url)
        end

        it 'should save the retweets' do
          News.first.retweets.should eq(10)
        end

        it 'should save the time of news' do
          News.first.time.should eq(start_time)
        end

        it 'should save the team' do
          News.first.team.should eq(team)
        end

        it 'should save the url title' do
          News.first.title.should match /Torcida apoia, incendeia Mané/
        end

        it 'should save the url description' do
          News.first.description.should match /Mano diz que incentivo/
        end

        it 'should save the url image_url' do
          News.first.image_url.should match /torcida_flamengo_cahe.jpg/
        end
      end

      context 'tweet without url' do
        it 'should not save new tweet' do
          News.create_by_tweet(tweet, team)
          News.count.should eq(0)
        end
      end
    end
    context 'old news' do
      context 'shorted news' do
        before(:each) do
          expanded_url = {}
          expanded_url.stub(:expanded_url) { 'shorted_url.com' }
          tweet.stub(:urls) { [expanded_url] }

          url_with_params = url
          url_with_params << '?utm_term=a'
          url_with_params << '&utm_content=b'
          url_with_params << '&utm_source=c'
          url_with_params << '&utm_medium=d'
          url_with_params << '&utm_campaign=e'

          Unshortme.stub(:unshort).with('shorted_url.com') { url_with_params }
          News.create_by_tweet(tweet, team)
          News.create_by_tweet(tweet, team)
        end

        it 'should save one time' do
          News.count.should eq(1)
        end
      end

      context 'expanded news' do
        before(:each) do
          expanded_url = {}
          expanded_url.stub(:expanded_url) { 'shorted_url.com' }
          tweet.stub(:urls) { [expanded_url] }

          url_with_params = url
          url_with_params << '?utm_term=a'
          url_with_params << '&utm_content=b'
          url_with_params << '&utm_source=c'
          url_with_params << '&utm_medium=d'
          url_with_params << '&utm_campaign=e'
          Unshortme.stub(:unshort).with('shorted_url.com') { url_with_params }
          News.create_by_tweet(tweet, team)

          expanded_url.stub(:expanded_url) { 'shorted2_url.com' }
          Unshortme.stub(:unshort).with('shorted2_url.com') { url_with_params }

          News.create_by_tweet(tweet, team)
        end

        it 'should save one time' do
          News.count.should eq(1)
        end
      end
    end
  end
end
