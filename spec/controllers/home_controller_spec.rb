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
    Team.stub_chain(:order, :all)             { [{}, {}] }

    Match.stub_chain(:order, :all)            { [{}, {}] }
    Match.stub_chain(:includes, :order, :all) { [{}, {}] }

    Championship.stub(:all)                   { [{}, {}] }
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
      assigns(:matches).should eq(Match.order(:start_time).all)
    end

    it 'should assigns all teams as @teams' do
      UpdateMatchService
          .stub_chain(:new, :update_matches_from_internet) { true }

      get :index
      assigns(:teams).should eq(Team.order(:name).all)
    end

    it 'should assigns all championships as @championships' do
      get :index
      assigns(:championships).should eq(Championship.all)
    end

    it 'should load all teams once' do
      Team.order(:name).should_receive(:all).once
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
