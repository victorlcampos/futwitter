require 'spec_helper'

describe Move do
  context 'relationships' do
    it { should belong_to(:match) }
  end
  context 'default order' do
    let!(:move_1) { FactoryGirl.create(:move, minute: 10, half: 1) }
    let!(:move_2) { FactoryGirl.create(:move, minute: 5,  half: 2) }
    let!(:move_3) { FactoryGirl.create(:move, minute: 15, half: 1) }

    it 'should order by minute ASC' do
      Move.all.should eq([move_2, move_3, move_1])
    end
  end

  context 'geters and seters' do
    describe '#team_name=(name)' do
      it 'should save team_name as downcase' do
        subject.team_name = 'FlaMengO'
        subject.save!
        subject.stub(team_name: subject.read_attribute(:team_name))
        subject.team_name.should eq('flamengo')
      end
    end

    describe '#name' do
      context 'when have team_name' do
        it 'should return name as humanize' do
          subject.team_name = 'FlaMengO'
          subject.save!
          subject.team_name.should eq('Flamengo')
        end
      end
      context 'when do not have team_name' do
        it 'should return name as humanize' do
          subject.team_name = nil
          subject.save!
          subject.team_name.should eq(nil)
        end
      end
    end
  end
end
