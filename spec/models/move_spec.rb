require 'spec_helper'

describe Move do
  context 'relationships' do
    it { should belong_to(:match) }
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

  end
end
