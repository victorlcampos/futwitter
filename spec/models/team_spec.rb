require 'spec_helper'

describe Team do
  subject(:flamengo)      { FactoryGirl.create(:flamengo) }

  context 'relationships' do
    it { should have_many(:home_matches).class_name('Match') }
    it { should have_many(:away_matches).class_name('Match') }
    it { should have_many(:news) }
  end

  context "general methods" do
    let(:flamengo_vs_vasco) { FactoryGirl.create(:flamengo_vs_vasco, home_team: flamengo) }
    let(:botafogo_vs_vasco) { FactoryGirl.create(:botafogo_vs_flamengo, away_team: flamengo) }

    its(:matches)       { should eq([flamengo_vs_vasco, botafogo_vs_vasco]) }
    its(:current_match) { should eq(botafogo_vs_vasco) }
  end

  context "geters and seters" do
    describe ".name=(name)" do
      it "should save name as downcase" do
        flamengo.name = "FlaMengO"
        flamengo.save!
        flamengo.stub(name: flamengo.read_attribute(:name))
        flamengo.name.should eq("flamengo")
      end
    end

    describe ".name" do
      it "should return name as humanize" do
        flamengo.name = "FlaMengO"
        flamengo.save!
        flamengo.name.should eq("Flamengo")
      end
    end

    describe ".badge_url" do
      describe "when have a badge" do
        its(:badge_url) { should_not be_nil }
      end

      describe "when don't have a badge" do
        it "should return the default badge" do
          flamengo.remove_badge!
          flamengo.badge_url.should eq("default.png")
        end
      end
    end
  end
end
