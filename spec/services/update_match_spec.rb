# encoding: utf-8
require 'spec_helper'

describe UpdateMatchService do
  context 'constants' do
    describe 'LANCENET_URL' do
      it 'should be the temporeal url' do
        lancenet_url = 'http://temporeal.lancenet.com.br/'
        UpdateMatchService::LANCENET_URL.should eq(lancenet_url)
      end
    end
  end

  context 'parse matches from internet' do
    describe 'self.update_matches_from_internet' do

      before(:each) do
        stub_const('UpdateMatchService::LANCENET_URL', File.join(Rails.root,
                                          'spec',
                                          'support', 'urls',
                                          'temporeal_lancenet.html'))

        UpdateMatchService.new.update_matches_from_internet
      end

      context 'teams' do
        describe 'did not exist' do
          it 'should create teams from url' do
            Team.count.should eq(56)
          end

          it 'should save the teams name' do
            Team.where(name: 'flamengo').first.should_not be_nil
            Team.where(name: 'olaria').first.should_not be_nil
            Team.where(name: 'brasil').first.should_not be_nil
          end
        end

        describe 'exist' do
          it 'should not create teams from url' do
            UpdateMatchService.new.update_matches_from_internet
            Team.count.should  eq(56)
          end
        end
      end

      context 'championship' do
        describe 'did not exist' do
          it 'should create teams from url' do
            Championship.count.should eq(7)
          end

          it 'should save the teams name' do
            Championship.where(name: 'Campeonato Gaúcho'.downcase)
                        .first.should_not be_nil
            Championship.where(name: 'Eliminatórias Sul-Americanas'.downcase)
                        .first.should_not be_nil
            Championship.where(name: 'Amistosos Internacionais'.downcase)
                        .first.should_not be_nil
          end
        end

        describe 'exist' do
          it 'should not create teams from url' do
            UpdateMatchService.new.update_matches_from_internet
            Championship.count.should eq(7)
          end
        end
      end

      context 'matches' do
        describe 'did no exist' do
          let(:first_match)  { Match.first }
          let(:medium_match) { Match.find(14) }
          let(:last_match)  { Match.last }

          it 'should create matches from url' do
            Match.count.should  eq(28)
          end

          it 'should save the score of match' do
            first_match.home_team_score.should eq(0)
            first_match.away_team_score.should eq(0)

            medium_match.home_team_score.should eq(1)
            medium_match.away_team_score.should eq(1)

            last_match.home_team_score.should eq(2)
            last_match.away_team_score.should eq(2)
          end

          it 'should save the championship name' do
            championship_name = 'Campeonato gaúcho'
            first_match.championship_name.should eq(championship_name)

            championship_name = 'Eliminatórias sul-americanas'
            medium_match.championship_name.should eq(championship_name)

            championship_name = 'Amistosos internacionais'
            last_match.championship_name.should eq(championship_name)
          end
        end

        describe 'matches exist' do
          before(:each) do
            stub_const('UpdateMatchService::LANCENET_URL',
                                      File.join(Rails.root,
                                      'spec',
                                      'support', 'urls',
                                      'temporeal_lancenet_score_changed.html'))
          end

          it 'should not create matches from url' do
            UpdateMatchService.new.update_matches_from_internet
            Match.count.should  eq(28)
          end

          it 'should update scores' do
            UpdateMatchService.new.update_matches_from_internet

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