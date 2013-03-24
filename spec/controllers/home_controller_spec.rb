require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should returns http success" do
      get 'index'
      response.should be_success
    end

    it "should assigns all matches as @matches" do
      flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco)
      fluminense_vs_botafogo = FactoryGirl.create(:fluminense_vs_botafogo)

      get :index
      assigns(:matches).should eq(Match.all)
    end
  end

end
