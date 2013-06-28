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
      Team.stub(:find).with(team.id) { team }
      Daemons.stub(:run) { true }
    end

    it 'should find team' do
      Team.should_receive(:find).with(team.id).once
      TwitterStream.perform(team.id)
    end

    it 'should create daemon process' do
      options = {
        app_name: team.name,
        ARGV: ['start', '-f', '--', "team=#{team.id}"],
        dir: Rails.root.join('pids'),
        backtrac: true,
        monitor: true
      }
      Daemons.should_receive(:run)
                    .with(TwitterStream::DAEMON_FILE, options).once
      TwitterStream.perform(team.id)
    end
  end
end