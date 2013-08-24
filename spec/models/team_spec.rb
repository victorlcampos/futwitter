require 'spec_helper'
require 'carrierwave/test/matchers'

describe Team do
  include CarrierWave::Test::Matchers
  subject(:flamengo) { FactoryGirl.create(:flamengo) }

  context 'relationships' do
    it do
      should have_many(:home_matches).class_name('Match').dependent(:destroy)
    end
    it do
      should have_many(:away_matches).class_name('Match').dependent(:destroy)
    end
    it { should have_many(:news) }
    it { should have_many(:photos) }
    it { should have_many(:tweets) }
  end

  context 'general methods' do
    let!(:campeonato_carioca) do
      FactoryGirl.create(:campeonato_carioca)
    end
    let!(:brasileirao) do
      FactoryGirl.create(:campeonato_brasileiro)
    end
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

    its(:matches)       { should eq([flamengo_vs_vasco, botafogo_vs_vasco]) }
    its(:championships) { should eq([campeonato_carioca, brasileirao]) }
    its(:championships_ids) { should eq([1, 2]) }

    its(:current_match) { should eq(botafogo_vs_vasco) }

    its(:current_match_start_time) do
      should eq(subject.current_match.start_time)
    end

    its(:current_match_open_time) do
      should eq(subject.current_match.open_time)
    end

    its(:current_match_close_time) do
      should eq(subject.current_match.close_time)
    end

    describe '#match_tweets(match)' do
      let(:match) do
        flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco)
        Match.find(flamengo_vs_vasco.id)
      end

      it 'should return tweets in match time' do
        subject.match_tweets(match)
          .should eq(subject.tweets.match_tweets(match))
      end
    end
  end

  context 'geters and seters' do
    describe '#name=(name)' do
      it 'should save name as downcase' do
        flamengo.name = 'FlaMengO'
        flamengo.save!
        flamengo.stub(name: flamengo.read_attribute(:name))
        flamengo.name.should eq('flamengo')
      end
    end

    describe '#name' do
      it 'should return name as humanize' do
        flamengo.name = 'FlaMengO'
        flamengo.save!
        flamengo.name.should eq('Flamengo')
      end
    end

    describe '#badge_url' do
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

  context 'callbacks' do
    context 'after create' do
      it 'should schedule twitter stream' do
        worker = TwitterStream
        team_id = 1
        Resque.stub(:enqueue) { true }
        Resque.should_receive(:enqueue)
                              .with(worker).once

        FactoryGirl.create(:flamengo, id: team_id)
      end
    end
  end
end
