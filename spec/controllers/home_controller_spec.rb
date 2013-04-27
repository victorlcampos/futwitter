require 'spec_helper'

describe HomeController do
  before(:each) do
    stub_const('UpdateMatchService::LANCENET_URL',
                File.join(Rails.root, 'spec', 'support',
                                      'urls', 'temporeal_lancenet.html'))

    get :index
  end

  describe 'GET "index"' do
    it 'should returns http success' do
      response.should be_success
    end

    it 'should update matches from internet' do
      Match.count.should eq(28)
    end

    it 'should assigns all matches as @matches' do
      assigns(:matches).should eq(Match.all)
    end

    it 'should assigns all teams as @teams' do
      assigns(:teams).should eq(Team.all)
    end

    it 'should assigns all championships as @championships' do
      assigns(:championships).should eq(Championship.all)
    end

    it 'should load all teams once' do
      Team.should_receive(:all).once
      get :index
    end

    it 'should load all championships once' do
      Championship.should_receive(:all).once
      get :index
    end
  end
end
