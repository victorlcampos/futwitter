require 'spec_helper'

describe HomeController do
  before(:each) do
    stub_const('Match::LANCENET_URL',
                File.join(Rails.root, 'spec', 'support',
                                      'urls', 'temporeal_lancenet.html'))

    get :index
  end

  describe 'GET "index"' do
    it 'should returns http success' do
      response.should be_success
    end

    it 'should update matches from internet' do
      Match.count.should eq(28)
    end

    it 'should assigns all matches as @matches' do
      assigns(:matches).should eq(Match.all)
    end
  end
end
