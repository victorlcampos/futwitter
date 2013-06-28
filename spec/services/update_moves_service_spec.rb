# encoding: utf-8
require 'spec_helper'

describe UpdateMovesService do
  context 'constants' do
    describe 'FIRST_HALF' do
      it 'should be the FIRST_HALF url' do
        first_half = 'etapa-1.htm'
        UpdateMovesService::FIRST_HALF.should eq(first_half)
      end
    end

    describe 'SECOND_HALF' do
      it 'should be the SECOND_HALF url' do
        second_half = 'etapa-2.htm'
        UpdateMovesService::SECOND_HALF.should eq(second_half)
      end
    end
  end

  context 'parse score from internet' do
    describe '#update_moves_from_internet' do
      let!(:flamengo_vs_vasco) do
        stub_const('UpdateMatchService::LANCENET_URL',
                                            File.join(Rails.root, 'spec', '/'))
        params = {
          internet_url: File.join('support', 'urls', '/')
        }

        FactoryGirl.create(:flamengo_vs_vasco, params)
      end
      before(:each) do
        UpdateMovesService.new(flamengo_vs_vasco).update_moves_from_internet
      end

      context 'moves did not exists' do
        let(:gol_move)  { Move.find(2) }
        let(:medium_move) { Move.find(5) }
        let(:last_move)  { Move.find(9) }

        it 'should create moves from url' do
          Move.count.should  eq(9)
        end

        it 'should save the match' do
          gol_move.match.should eq(flamengo_vs_vasco)
          medium_move.match.should eq(flamengo_vs_vasco)
          last_move.match.should eq(flamengo_vs_vasco)
        end

        it 'should save the minute' do
          gol_move.minute.should eq(43)
          medium_move.minute.should eq(48)
          last_move.minute.should eq(0)
        end

        it 'should save the half' do
          gol_move.half.should    eq(1)
          medium_move.half.should eq(2)
          last_move.half.should   eq(2)
        end

        it 'should save the move text' do
          move_text = /GOL DO AMÉRICA-RN!/
          gol_move.text.should match(move_text)

          move_text = /FIM DE JOGO!/
          medium_move.text.should match(move_text)

          move_text = /COMEÇA O SEGUNDO TEMPO!/
          last_move.text.should match(move_text)
        end

        it 'should save the team name' do
          gol_move.team_name.should eq('América-rn')
          medium_move.team_name.should eq nil
          last_move.team_name.should eq nil
        end
      end
      context 'moves exists' do
        let(:gol_move)  { Move.find(2) }
        let(:medium_move) { Move.find(5) }
        let(:last_move)  { Move.find(9) }

        it 'should create moves from url' do
          UpdateMovesService.new(flamengo_vs_vasco).update_moves_from_internet
          Move.count.should  eq(9)
        end
      end
    end
  end
end