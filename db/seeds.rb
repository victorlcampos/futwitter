require 'factory_girl'
Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}

flamengo   = FactoryGirl.create(:flamengo)
vasco      = FactoryGirl.create(:vasco)
fluminense = FactoryGirl.create(:fluminense)
botafogo   = FactoryGirl.create(:botafogo)

flamengo_vs_vasco      = FactoryGirl.create(:flamengo_vs_vasco, home_team: flamengo, away_team: vasco)
botafogo_vs_flamengo   = FactoryGirl.create(:botafogo_vs_flamengo, home_team: botafogo, away_team: flamengo)
fluminense_vs_botafogo = FactoryGirl.create(:fluminense_vs_botafogo, home_team: fluminense, away_team: botafogo)

news_flamengo_1 = FactoryGirl.create(:news_flamengo_1, team: flamengo)
news_flamengo_2 = FactoryGirl.create(:news_flamengo_2, team: flamengo)

flamengo_vs_vasco_move_1 = FactoryGirl.create(:flamengo_vs_vasco_move_1, match: flamengo_vs_vasco)
flamengo_vs_vasco_move_2 = FactoryGirl.create(:flamengo_vs_vasco_move_2, match: flamengo_vs_vasco)