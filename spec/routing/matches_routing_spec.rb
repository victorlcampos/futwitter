require 'spec_helper'

describe MatchesController do
  describe 'routing' do
    it 'routes to #show' do
      get('/matches/1').should route_to('matches#show', id: '1')
    end
  end
end
