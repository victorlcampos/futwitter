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

  context "geters and seters" do
    describe ".name=(name)" do
      it "should save name as downcase" do
        flamengo = FactoryGirl.create(:flamengo)
        flamengo.name = "FlaMengO"
        flamengo.save!
        flamengo.stub(name: flamengo.read_attribute(:name))
        flamengo.name.should eq("flamengo")
      end
    end

    describe ".name" do
      it "should return name as humanize" do
        flamengo = FactoryGirl.create(:flamengo)
        flamengo.name = "FlaMengO"
        flamengo.save!
        flamengo.name.should eq("Flamengo")
      end
    end

    describe ".badge_url" do
      describe "when have a badge" do
        it "should return the badge url" do
          flamengo = FactoryGirl.create(:flamengo)
          flamengo.badge_url.should_not be_nil
        end
      end

      describe "when don't have a badge" do
        it "should return the default badge" do
          flamengo = FactoryGirl.create(:flamengo)
          flamengo.remove_badge!
          flamengo.badge_url.should eq("default.png")
        end
      end
    end
  end

end
