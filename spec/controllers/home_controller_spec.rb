#encoding: UTF-8

require 'spec_helper'

describe HomeController do
  before(:all) do
    real_lancenet_url = UpdateMatchService::LANCENET_URL
    fake_lancenet_url = File.join(Rails.root, 'spec', 'support', 'urls',
                                         'temporeal_lancenet.html')
    FakeWeb.register_uri(:get, real_lancenet_url,
                               body: open(fake_lancenet_url).read)

    fake_match_url = File.join(Rails.root, 'spec', 'support', 'urls',
                          'Grêmio 2 x 0 Caxias - Lancenet Tempo Real.html')
    FakeWeb.register_uri(:get, %r|#{real_lancenet_url}|,
                               body: open(fake_match_url).read)

    fake_gremio_image = File.join(Rails.root, 'spec', 'support', 'image',
                                                              'gremio.png')
    fake_caxias_image = File.join(Rails.root, 'spec', 'support', 'image',
                                                              'caxias.png')

    FakeWeb.register_uri(:get, "#{real_lancenet_url}/image/gremio.png",
                               body: open(fake_gremio_image))
    FakeWeb.register_uri(:get, "#{real_lancenet_url}/image/caxias.png",
                               body: open(fake_caxias_image))
  end

  before(:each) do
    team_1 = { 'name' => 'team_1' }
    team_1.stub(:current_match) { { name: 'jogo 1', start_time: 2 } }

    team_2 = { 'name' => 'team_2' }
    team_2.stub(:current_match) { { name: 'jogo 2', start_time: 1 } }

    team_3 = { 'name' => 'team_3' }
    team_3.stub(:current_match) { { name: 'jogo 2', start_time: 1 } }

    Team.stub_chain(:order, :all)              { [team_1, team_2, team_3] }

    Championship.stub(:order_by_matches_count) { [{}, {}] }
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

    it 'should assigns current matches as @matches' do
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }

      get :index
      assigns(:matches).should eq([{ 'name' => 'jogo 2', 'start_time' => 1 },
                                   { 'name' => 'jogo 1', 'start_time' => 2 }])
    end

    it 'should assigns all teams as @teams' do
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }

      get :index
      assigns(:teams).should eq(Team.order(:name).all)
    end

    it 'should assigns all championships as @championships' do
      get :index
      assigns(:championships).should eq(Championship.order_by_matches_count)
    end

    it 'should load all teams once' do
      Team.order(:name).should_receive(:all).once
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }
      get :index
    end

    it 'should load all championships once' do
      Championship.should_receive(:order_by_matches_count).once
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }
      get :index
    end
  end
end
