require 'spec_helper'

describe TeamsController do
  describe 'routing' do
    it 'routes to #show' do
      get('/teams/1').should route_to('teams#show', id: '1')
    end
  end
end
