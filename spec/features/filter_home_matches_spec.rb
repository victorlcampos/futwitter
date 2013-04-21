require 'spec_helper'

describe "filtring matches" do
  before(:each) do
    stub_const('Match::LANCENET_URL', File.join(Rails.root, 'spec',
                'support',
                'urls', 'temporeal_lancenet_score_changed.html'))
  end

  it "should show the current championship" do
    visit '/'
  end
end