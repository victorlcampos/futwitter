require 'spec_helper'

describe TeamsController do
  describe 'GET show' do
    before(:each) do
      @flamengo = FactoryGirl.create(:flamengo)

      FactoryGirl.create(:flamengo_vs_vasco   , home_team: @flamengo)
      FactoryGirl.create(:botafogo_vs_flamengo, away_team: @flamengo)
      FactoryGirl.create(:news_flamengo_1     ,      team: @flamengo)

      FactoryGirl.create(:trusted_domain, name: 'globo')
      FactoryGirl.create(:trusted_domain, name: 'sportv')
      FactoryGirl.create(:trusted_domain, name: 'espm')

      get :show, { id: @flamengo.to_param }
    end

    it 'should assigns the requested team as @team' do
      assigns(:team).should eq(@flamengo)
    end

    it 'should assigns the current match as @match' do
      assigns(:match).should eq(@flamengo.current_match)
    end

    it 'should assigns the news as @news' do
      assigns(:news).should eq(@flamengo.news)
    end

    it 'should assings the trusted domains as @trusted_domains' do
      assigns(:trusted_domains).should eq(['globo', 'sportv', 'espm'])
    end
  end
end
