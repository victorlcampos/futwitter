require 'spec_helper'

describe ApplicationController do

  controller do
    def index
      render nothing: true
    end
  end

  context 'filters' do
    describe 'before_filter load_teams' do
      it 'should assigns all teams as @teams' do
        flamengo = FactoryGirl.create(:flamengo)
        vasco = FactoryGirl.create(:vasco)

        campeonato_carioca = FactoryGirl.create(:campeonato_carioca)

        get :index
        assigns(:teams).should eq([flamengo, vasco])
        assigns(:championships).should eq([campeonato_carioca])
      end
    end
  end

end