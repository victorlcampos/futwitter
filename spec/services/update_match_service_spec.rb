#encoding: UTF-8
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

  context 'parse score from internet' do
    describe '#update_matches_from_internet' do
      before(:all) do
        real_lancenet_url = UpdateMatchService::LANCENET_URL
        fake_lancenet_url = File.join(Rails.root, 'spec', 'support', 'urls',
                                             'temporeal_lancenet.html')
        FakeWeb.register_uri(:get, real_lancenet_url,
                                   body: open(fake_lancenet_url).read)

        fake_match_url = File.join(Rails.root, 'spec', 'support', 'urls',
                              'Grêmio 2 x 0 Caxias - Lancenet Tempo Real.html')
        FakeWeb.register_uri(:get, %r|#{real_lancenet_url}|,
                                   body: open(fake_match_url).read)

        fake_gremio_image = File.join(Rails.root, 'spec', 'support', 'image',
                                                                  'gremio.png')
        fake_caxias_image = File.join(Rails.root, 'spec', 'support', 'image',
                                                                  'caxias.png')

        FakeWeb.register_uri(:get, "#{real_lancenet_url}/image/gremio.png",
                                   body: open(fake_gremio_image))
        FakeWeb.register_uri(:get, "#{real_lancenet_url}/image/caxias.png",
                                   body: open(fake_caxias_image))
      end
      before(:each) do
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

          it 'should save images' do
            default_url = BadgeUploader.new.default_url

            gremio = Team.where(name: 'grêmio').first
            gremio.badge_url.should_not eq(default_url)

            caxias = Team.where(name: 'caxias').first
            caxias.badge_url.should_not eq(default_url)
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
          let(:first_match)  { Match.find(1) }
          let(:medium_match) { Match.find(14) }
          let(:last_match)  { Match.find(28) }

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

          it 'should save the internet url' do
            internet_url = '/2013/campeonato-gaucho/23-mar/gremio-caxias/'
            first_match.internet_url.should eq(internet_url)

            internet_url =
                  '/2013/eliminatorias-sul-americanas/22-mar/uruguai-paraguai/'
            medium_match.internet_url.should eq(internet_url)

            internet_url =
                  '/2013/amistosos-internacionais/21-mar/brasil-italia/'
            last_match.internet_url.should eq(internet_url)
          end

          it 'should save the match time' do
            first_match.start_time.should eq(Time.new(2013, 3, 23, 21))
            last_match.start_time.should eq(Time.new(2013, 3, 21, 16))
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

            first_match = Match.find(1)
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