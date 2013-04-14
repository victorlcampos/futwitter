# encoding: utf-8
require 'spec_helper'

describe Match do
  context 'relationships' do
    it { should belong_to(:home_team).class_name('Team') }
    it { should belong_to(:away_team).class_name('Team') }
    it { should belong_to(:championship) }
    it { should have_many(:moves) }
  end

  context "constants" do
    describe "LANCENET_URL" do
      it "should be the temporeal url" do
        Match::LANCENET_URL.should eq("http://temporeal.lancenet.com.br/")
      end
    end
  end

  context "delegated mathods" do
    subject(:flamengo_vs_vasco) {FactoryGirl.create(:flamengo_vs_vasco)}
    its(:home_team_name) { should eq("Flamengo") }
    its(:away_team_name) { should eq("Vasco") }
    its(:championship_name) { should eq("Campeonato carioca") }

    its(:home_team_badge_url) { should eq(flamengo_vs_vasco.home_team.badge_url) }
    its(:away_team_badge_url) { should eq(flamengo_vs_vasco.away_team.badge_url) }
  end

  context "parse matches from internet" do
    describe "self.update_matches_from_internet" do

      before(:each) do
        stub_const("Match::LANCENET_URL", File.join(Rails.root, 'spec', 'support', 'urls', 'temporeal_lancenet.html'))
        Match.update_matches_from_internet
      end

      context "teams" do
        describe "did not exist" do
          it "should create teams from url" do
            Team.count.should eq(56)
          end

          it "should save the teams name" do
            Team.where(name: "flamengo").first.should_not be_nil
            Team.where(name: "olaria").first.should_not be_nil
            Team.where(name: "brasil").first.should_not be_nil
          end
        end

        describe "exist" do
          it "should not create teams from url" do
            Match.update_matches_from_internet
            Team.count.should  eq(56)
          end
        end
      end

      context "championship" do
        describe "did not exist" do
          it "should create teams from url" do
            Championship.count.should eq(7)
          end

          it "should save the teams name" do
            Championship.where(name: "Campeonato Gaúcho".downcase).first.should_not be_nil
            Championship.where(name: "Eliminatórias Sul-Americanas".downcase).first.should_not be_nil
            Championship.where(name: "Amistosos Internacionais".downcase).first.should_not be_nil
          end
        end

        describe "exist" do
          it "should not create teams from url" do
            Match.update_matches_from_internet
            Championship.count.should eq(7)
          end
        end
      end

      context "matches" do
        describe "did no exist" do
          let(:first_match)  { Match.first }
          let(:medium_match) { Match.find(14) }
          let(:last_match)  { Match.last }

          it "should create matches from url" do
            Match.count.should  eq(28)
          end

          it "should save the score of match" do
            first_match.home_team_score.should eq(0)
            first_match.away_team_score.should eq(0)

            medium_match.home_team_score.should eq(1)
            medium_match.away_team_score.should eq(1)

            last_match.home_team_score.should eq(2)
            last_match.away_team_score.should eq(2)
          end

          it "should save the championship name" do
            first_match.championship_name.should eq("Campeonato Gaúcho")
            first_match.championship_name.should eq("Eliminatórias Sul-Americanas")
            first_match.championship_name.should eq("Amistosos Internacionais")
          end
        end

        describe "matches exist" do
          it "should not create matches from url" do
            Match.update_matches_from_internet
            Match.count.should  eq(28)
          end

          it "should update scores" do
            stub_const("Match::LANCENET_URL", File.join(Rails.root, 'spec', 'support', 'urls', 'temporeal_lancenet_score_changed.html'))
            Match.update_matches_from_internet

            first_match = Match.first
            first_match.home_team_score.should eq(1)
            first_match.away_team_score.should eq(2)

            medium_match = Match.find(14)
            medium_match.home_team_score.should eq(2)
            medium_match.away_team_score.should eq(1)

            last_match = Match.last
            last_match.home_team_score.should eq(2)
            last_match.away_team_score.should eq(2)
          end
        end
      end
    end
  end
end
