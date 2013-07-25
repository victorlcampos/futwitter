require 'spec_helper'

describe Championship do
  subject(:campeonato_carioca) { FactoryGirl.create(:campeonato_carioca) }

  context 'relationships' do
    it { should have_many(:matches) }
  end

  context 'scope' do
    let!(:championship01) do
      FactoryGirl.create(:campeonato_carioca, matches_count: 1)
    end

    let!(:championship02) do
      FactoryGirl.create(:campeonato_carioca, matches_count: 3)
    end

    let!(:championship03) do
      FactoryGirl.create(:campeonato_carioca, matches_count: 2)
    end

    describe '.order_by_matches_count' do
      it 'should order by matches_count' do
        Championship.order_by_matches_count.should
                            eq([championship02, championship03, championship01])
      end
    end
  end

  context 'geters and seters' do
    describe '#name=(name)' do
      it 'should save name as downcase' do
        campeonato_carioca.name = 'Campeonato Carioca'
        campeonato_carioca.save!
        campeonato_carioca.stub(name: campeonato_carioca.read_attribute(:name))
        campeonato_carioca.name.should eq('campeonato carioca')
      end
    end

    describe '#name' do
      it 'should return name as humanize' do
        campeonato_carioca.name = 'Campeonato Carioca'
        campeonato_carioca.save!
        campeonato_carioca.name.should eq('Campeonato carioca')
      end
    end
  end
end
