require 'spec_helper'

describe MatchesController do
  let!(:start_time) { Time.zone.now }

  describe 'GET show' do
    let!(:flamengo_vs_vasco) do
      stub_const('UpdateMatchService::LANCENET_URL',
                                          File.join(Rails.root, 'spec', '/'))
      params = {
        internet_url: File.join('support', 'urls', '/'),
        start_time: start_time
      }

      FactoryGirl.create(:flamengo_vs_vasco, params)
    end

    let!(:presenter) { MatchesShowPresenter.new(flamengo_vs_vasco) }

    before(:each) do
      MatchesShowPresenter.stub(:new).with(flamengo_vs_vasco) { presenter }
      get :show, { id: flamengo_vs_vasco.to_param }
    end

    it 'should assigns the match moves as @moves' do
      flamengo_vs_vasco.moves.count.should eq(9)
    end

    it 'should assigns the presenter @presenter' do
      assigns(:presenter).should eq(presenter)
    end
  end
end