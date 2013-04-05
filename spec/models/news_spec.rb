require 'spec_helper'

describe News do
  context 'relationships' do
    it { should belong_to(:team) }
  end
end
