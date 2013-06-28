require 'spec_helper'

describe MatchesController do
  let!(:start_time) { Time.zone.now }

  describe 'GET show' do
    let!(:flamengo_vs_vasco) do
      stub_const('UpdateMatchService::LANCENET_URL',
                                          File.join(Rails.root, 'spec', '/'))
      params = {
        internet_url: File.join('support', 'urls', '/'),
        start_time: start_time
      }

      FactoryGirl.create(:flamengo_vs_vasco, params)
    end

    before(:each) do
      flamengo_vs_vasco.stub_chain(:home_team, :tweets_count) { 3 }
      flamengo_vs_vasco.stub_chain(:away_team, :tweets_count) { 1 }

      Time.zone.stub(:now) { start_time - 27.minutes }
      Match.stub(:find).with(flamengo_vs_vasco.id.to_s) { flamengo_vs_vasco }

      get :show, { id: flamengo_vs_vasco.to_param }
    end

    it 'should assigns the requested match as @match' do
      assigns(:match).should eq(flamengo_vs_vasco)
    end

    it 'should assigns the match moves as @moves' do
      flamengo_vs_vasco.moves.count.should eq(9)
    end

    it 'should assigns the match moves as @moves' do
      assigns(:moves).should eq(flamengo_vs_vasco.moves)
    end

    it 'should assign home_tweets_per_minutes as 1' do
      assigns(:home_tweets_per_minute).should eq(1)
    end

    it 'should assign away_tweets_per_minutes as 0' do
      assigns(:away_tweets_per_minute).should eq(0)
    end
  end
end
