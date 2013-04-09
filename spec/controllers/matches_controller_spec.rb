require 'spec_helper'

describe MatchesController do
  describe "GET show" do
    let!(:flamengo_vs_vasco) { FactoryGirl.create(:flamengo_vs_vasco) }
    let!(:flamengo_vs_vasco_move1) { FactoryGirl.create(:flamengo_vs_vasco_move_1, match: flamengo_vs_vasco) }
    let!(:flamengo_vs_vasco_move2) { FactoryGirl.create(:flamengo_vs_vasco_move_2, match: flamengo_vs_vasco) }

    before(:each) { get :show, { id: flamengo_vs_vasco.to_param } }

    it "should assigns the requested match as @match" do
      assigns(:match).should eq(flamengo_vs_vasco)
    end

    it "should assigns the match moves as @moves" do
      assigns(:moves).should eq([flamengo_vs_vasco_move2, flamengo_vs_vasco_move1])
    end
  end
end
