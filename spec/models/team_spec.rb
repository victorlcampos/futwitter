require 'spec_helper'

describe Team do
  context 'relationships' do
    it { should have_many(:home_matches).class_name('Match') }
    it { should have_many(:away_matches).class_name('Match') }
    it { should have_many(:news) }
  end

  context "general methods" do

    describe ".matches" do
      it "should return all team matches" do
        flamengo = FactoryGirl.create(:flamengo)

        flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco, home_team: flamengo)
        botafogo_vs_vasco = FactoryGirl.create(:botafogo_vs_flamengo, away_team: flamengo)

        flamengo.matches.should eq([flamengo_vs_vasco, botafogo_vs_vasco])
      end
    end


    describe ".current_match" do
      it "should return the last match" do
        flamengo = FactoryGirl.create(:flamengo)

        flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco, home_team: flamengo)
        botafogo_vs_vasco = FactoryGirl.create(:botafogo_vs_flamengo, away_team: flamengo)

        flamengo.current_match.should eq(botafogo_vs_vasco)
      end
    end
  end

end
