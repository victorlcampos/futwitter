# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

flamengo = Team.new
flamengo.name = "Flamengo"
flamengo.badge = File.open(File.join(Rails.root, 'spec', 'support', 'image', 'flamengo.jpg'))
flamengo.save!

vasco = Team.new
vasco.name = "Vasco"
vasco.badge = File.open(File.join(Rails.root, 'spec', 'support', 'image', 'vasco.png'))
vasco.save!

fluminense = Team.new
fluminense.name = "Fluminense"
fluminense.badge = File.open(File.join(Rails.root, 'spec', 'support', 'image', 'fluminense.png'))
fluminense.save!

botafogo = Team.new
botafogo.name = "Botafogo"
botafogo.badge = File.open(File.join(Rails.root, 'spec', 'support', 'image', 'botafogo.png'))
botafogo.save!

flamengo_vs_vasco = Match.new
flamengo_vs_vasco.home_team = flamengo
flamengo_vs_vasco.away_team = vasco
flamengo_vs_vasco.save!

botafogo_vs_fluminense = Match.new
botafogo_vs_fluminense.home_team = botafogo
botafogo_vs_fluminense.away_team = fluminense
botafogo_vs_fluminense.save!