require 'factory_girl'
Dir[Rails.root.join('spec/factories/*.rb')].each { |f| require f }

flamengo   = FactoryGirl.create(:flamengo)
vasco      = FactoryGirl.create(:vasco)
fluminense = FactoryGirl.create(:fluminense)
botafogo   = FactoryGirl.create(:botafogo)

flamengo_vs_vasco = FactoryGirl.create(:flamengo_vs_vasco,
                                             home_team: flamengo,
                                             away_team: vasco)

FactoryGirl.create(:botafogo_vs_flamengo,    home_team: botafogo,
                                             away_team: flamengo)

FactoryGirl.create(:fluminense_vs_botafogo,  home_team: fluminense,
                                             away_team: botafogo)

FactoryGirl.create(:news_flamengo_1, team: flamengo)
FactoryGirl.create(:news_flamengo_2, team: flamengo)

FactoryGirl.create(:flamengo_vs_vasco_move_1, match: flamengo_vs_vasco)
FactoryGirl.create(:flamengo_vs_vasco_move_2, match: flamengo_vs_vasco)