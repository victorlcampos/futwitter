require 'spec_helper'

describe MatchesController do
  describe "GET show" do
    before(:each) do
      @flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco)
      @flamengo_vs_vasco_move1 = FactoryGirl.create(:flamengo_vs_vasco_move_1, match: @flamengo_vs_vasco)
      @flamengo_vs_vasco_move2 = FactoryGirl.create(:flamengo_vs_vasco_move_2, match: @flamengo_vs_vasco)
    end

    it "should assigns the requested match as @match" do
      get :show, {:id => @flamengo_vs_vasco.to_param}
      assigns(:match).should eq(@flamengo_vs_vasco)
    end

    it "should assigns the match moves as @moves" do
      get :show, {:id => @flamengo_vs_vasco.to_param}
      assigns(:moves).should eq([@flamengo_vs_vasco_move2, @flamengo_vs_vasco_move1])
    end

  end
end
