require 'spec_helper'

describe News do
  context 'relationships' do
    it { should belong_to(:team) }
  end

  describe '.create_by_tweet(tweet, team)' do
    context 'new news' do
    end
    context 'old news' do
    end
  end
end
