require 'spec_helper'

describe TwitterStream do
  context 'constants' do
    describe 'DAEMON_FILE' do
      it 'should be the temporeal url' do
        daemon_file = File.join(Rails.root, 'lib', 'daemons', 'team_daemon.rb')
        TwitterStream::DAEMON_FILE.should eq(daemon_file)
      end
    end
  end

  it 'should enqueue in twitter queue' do
    TwitterStream.instance_variable_get(:@queue).should eq(:twitter)
  end

  describe '.perform' do
    let(:team) { FactoryGirl.create(:flamengo) }

    before(:each) do
      stub_const('TwitterStream::DAEMON_FILE',
                File.join(Rails.root, 'spec', 'support',
                                      'daemons', 'team_daemon.rb'))
      TwitterStream.stub(:system) { true }
    end

    it 'should create daemon process' do
      ruby_call = 'bundle exec ruby'
      start = "start team='#{team.id}'"
      TwitterStream.should_receive(:system)
              .with("#{ruby_call} #{TwitterStream::DAEMON_FILE} #{start}").once
      TwitterStream.perform(team.id)
    end
  end
end