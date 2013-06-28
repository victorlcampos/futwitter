require 'spec_helper'

describe HomeController do
  before(:each) do
    stub_const('UpdateMatchService::LANCENET_URL',
                File.join(Rails.root, 'spec', 'support',
                                      'urls', 'temporeal_lancenet.html'))

    Team.stub(:all)                   { [{}, {}] }
    Match.stub(:all)                  { [{}, {}] }
    Match.stub_chain(:includes, :all) { [{}, {}] }
    Championship.stub(:all)           { [{}, {}] }
  end

  describe 'GET "index"' do
    it 'should returns http success' do
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }
      get :index
      response.should be_success
    end

    it 'should update matches from internet' do
      get :index
      Match.count.should eq(28)
    end

    it 'should assigns all matches as @matches' do
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }

      get :index
      assigns(:matches).should eq(Match.all)
    end

    it 'should assigns all teams as @teams' do
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }

      get :index
      assigns(:teams).should eq(Team.all)
    end

    it 'should assigns all championships as @championships' do
      get :index
      assigns(:championships).should eq(Championship.all)
    end

    it 'should load all teams once' do
      Team.should_receive(:all).once
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }
      get :index
    end

    it 'should load all championships once' do
      Championship.should_receive(:all).once
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }
      get :index
    end
  end
end
