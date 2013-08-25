# encoding: utf-8
require 'spec_helper'

describe News do
  let!(:start_time) { Time.parse('2013-08-25T12:49:16-03:00') }

  context 'relationships' do
    it { should belong_to(:team) }
  end

  describe '.create_by_tweet(tweet, team)' do
    let!(:tweet) do
      {
        "retweet_count"=>10,
        "created_at"=>"2013-08-25T12:49:16-03:00",
        "url"=>"shorted_url.com"
      }
    end
    let!(:team) { FactoryGirl.create(:flamengo) }

    let!(:url) do
      unshorted_url = File.join(Rails.root, 'spec', 'support', 'urls',
                                                     'news_globoesporte.html')
    end

    let!(:url_with_params) do
      with_params = url
      with_params += '?utm_term=a'
      with_params += '&utm_content=b'
      with_params += '&utm_source=c'
      with_params += '&utm_medium=d'
      with_params += '&utm_campaign=e'
      with_params
    end

    before(:each) do
      Unshortme.stub(:unshort).with('shorted_url.com') { url_with_params }
      Unshortme.stub(:unshort).with( url_with_params ) { url_with_params }

      URI.stub(:remove_params) { url }

      News.create_by_tweet(tweet, team)
    end
    context 'new news' do
      context 'tweet with url' do
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
    end

    context 'old news' do
      context 'shorted news' do
        before(:each) do
          News.create_by_tweet(tweet, team)
        end

        it 'should save one time' do
          News.count.should eq(1)
        end
      end

      context 'expanded news' do
        before(:each) do
          tweet['url'] = 'shorted2_url.com'
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
