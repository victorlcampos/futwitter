require 'spec_helper'

describe Match do
  context 'relationships' do
    it { should belong_to(:home_team).class_name('Team') }
    it { should belong_to(:away_team).class_name('Team') }
  end

  context "delegated mathods" do
    before(:each) do
      @flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco)
    end

    describe ".home_team_name" do
      it "should return the name of home team" do
        @flamengo_vs_vasco.home_team_name.should eq("Flamengo")
      end
    end

    describe ".away_team_name" do
      it "should return the name of away team" do
        @flamengo_vs_vasco.away_team_name.should eq("Vasco")
      end
    end

    describe ".home_team_badge_url" do
      it "should return the badge url of home team" do
        @flamengo_vs_vasco.home_team_badge_url.should eq(@flamengo_vs_vasco.home_team.badge_url)
      end
    end


    describe ".away_team_badge_url" do
      it "should return the badge url of away team" do
        @flamengo_vs_vasco.away_team_badge_url.should eq(@flamengo_vs_vasco.away_team.badge_url)
      end
    end
  end
end
