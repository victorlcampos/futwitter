require 'spec_helper'
require 'carrierwave/test/matchers'

describe Team do
  include CarrierWave::Test::Matchers

  subject(:flamengo) { FactoryGirl.create(:flamengo) }

  context 'relationships' do
    it { should have_many(:home_matches).class_name('Match') }
    it { should have_many(:away_matches).class_name('Match') }
    it { should have_many(:news) }
  end

  context 'general methods' do
    let(:flamengo_vs_vasco) do
      FactoryGirl.create(:flamengo_vs_vasco, home_team: flamengo)
    end
    let(:botafogo_vs_vasco) do
      FactoryGirl.create(:botafogo_vs_flamengo, away_team: flamengo)
    end

    its(:matches)       { should eq([flamengo_vs_vasco, botafogo_vs_vasco]) }
    its(:current_match) { should eq(botafogo_vs_vasco) }
  end

  context 'geters and seters' do
    describe '.name=(name)' do
      it 'should save name as downcase' do
        flamengo.name = 'FlaMengO'
        flamengo.save!
        flamengo.stub(name: flamengo.read_attribute(:name))
        flamengo.name.should eq('flamengo')
      end
    end

    describe '.name' do
      it 'should return name as humanize' do
        flamengo.name = 'FlaMengO'
        flamengo.save!
        flamengo.name.should eq('Flamengo')
      end
    end

    describe '.badge_url' do
      describe 'when have a badge' do
        its(:badge_url) { should_not be_nil }

        it 'thumb version should not be nil' do
          flamengo.badge_url(:thumb).should_not be_nil
        end
      end

      describe 'when dont have a badge' do
        it 'should return the default badge' do
          flamengo.remove_badge!
          flamengo.badge_url.should eq('default.png')
          flamengo.badge_url(:thumb).should eq('thumb-default.png')
        end
      end
    end
  end
end
