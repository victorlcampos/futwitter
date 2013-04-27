# encoding: utf-8
require 'spec_helper'

describe Match do
  context 'relationships' do
    it { should belong_to(:home_team).class_name('Team') }
    it { should belong_to(:away_team).class_name('Team') }
    it { should belong_to(:championship) }
    it { should have_many(:moves) }
  end

  context 'delegated mathods' do
    subject(:flamengo_vs_vasco) { FactoryGirl.create(:flamengo_vs_vasco) }
    its(:home_team_name) { should eq('Flamengo') }
    its(:away_team_name) { should eq('Vasco') }
    its(:championship_name) { should eq('Campeonato carioca') }

    its(:home_team_badge_url) do
      should eq(flamengo_vs_vasco.home_team.badge_url)
    end

    its(:away_team_badge_url) do
      should eq(flamengo_vs_vasco.away_team.badge_url)
    end
  end
end