require 'spec_helper'

describe MatchesController do
  describe "GET show" do

    it "should assigns the requested match as @match" do
      flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco)

      get :show, {:id => flamengo_vs_vasco.to_param}
      assigns(:match).should eq(flamengo_vs_vasco)
    end

  end
end
