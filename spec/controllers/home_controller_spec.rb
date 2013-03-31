require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should returns http success" do
      get 'index'
      response.should be_success
    end

    it "should update matches from internet" do
      stub_const("Match::LANCENET_URL", File.join(Rails.root, 'spec', 'support', 'urls', 'temporeal_lancenet.html'))

      get :index
      Match.count.should eq(28)
    end

    it "should assigns all matches as @matches" do
      stub_const("Match::LANCENET_URL", File.join(Rails.root, 'spec', 'support', 'urls', 'temporeal_lancenet.html'))

      get :index
      assigns(:matches).should eq(Match.all)
    end
  end

end
