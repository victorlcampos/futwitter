require 'spec_helper'

describe TeamsController do
  describe "GET show" do
    before(:each) do
      @flamengo = FactoryGirl.create(:flamengo)

      flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco, home_team: @flamengo)
      botafogo_vs_vasco = FactoryGirl.create(:botafogo_vs_flamengo, away_team: @flamengo)

      flamengo_news = FactoryGirl.create(:news, team: @flamengo)

      get :show, {:id => @flamengo.to_param}
    end

    it "should assigns the requested team as @team" do
      assigns(:team).should eq(@flamengo)
    end

    it "should assigns the current match as @match" do
      assigns(:match).should eq(@flamengo.current_match)
    end

    it "should assigns the news as @news" do
      assigns(:news).should eq(@flamengo.news)
    end

  end
end
