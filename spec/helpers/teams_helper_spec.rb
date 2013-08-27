require 'spec_helper'

describe TeamsHelper do
  describe '.team_classes' do
    let(:flamengo)           { FactoryGirl.create(:flamengo) }
    let(:campeonato_carioca) { FactoryGirl.create(:campeonato_carioca) }
    let(:brasileirao)        { FactoryGirl.create(:campeonato_brasileiro) }

    let!(:flamengo_vs_vasco) do
      FactoryGirl.create(:flamengo_vs_vasco,
                                      home_team: flamengo,
                                      championship: campeonato_carioca)
    end
    let!(:botafogo_vs_vasco) do
      FactoryGirl.create(:botafogo_vs_flamengo,
                                      away_team: flamengo,
                                      championship: brasileirao)
    end

    it 'should return the championships filter class' do
      class_expected = 'filter championship_2 championship_1'
      helper.team_classes(flamengo).should eq(class_expected)
    end
  end
end