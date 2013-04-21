require 'spec_helper'

describe ApplicationController do

  controller do
    def index
      render nothing: true
    end
  end



  context 'before_filters' do
    # before(:each) { get :index }

    describe 'load_teams' do
      let!(:flamengo) { FactoryGirl.create(:flamengo) }
      let!(:vasco) { FactoryGirl.create(:vasco) }

      it 'should assigns all teams as @teams' do
        get :index
        assigns(:teams).should eq([flamengo, vasco])
      end
    end

    describe 'load_championships' do
      let!(:campeonato_carioca) { FactoryGirl.create(:campeonato_carioca) }

      it 'should assigns all championships as @championships' do
        get :index
        assigns(:championships).should eq([campeonato_carioca])
      end
    end
  end

end