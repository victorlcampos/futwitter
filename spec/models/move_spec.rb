require 'spec_helper'

describe Move do
  context 'relationships' do
    it { should belong_to(:match) }
  end
end
