require 'spec_helper'

describe ApplicationController do

  controller do
    def index
      render nothing: true
    end
  end

  context "filters" do
    describe ".load_team" do
      it "assigns all teams as @teams" do
        flamengo = FactoryGirl.create(:flamengo)
        vasco = FactoryGirl.create(:vasco)
        get :index
        assigns(:teams).should eq([flamengo, vasco])
      end
    end
  end

end