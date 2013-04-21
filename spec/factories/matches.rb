FactoryGirl.define do
  factory :flamengo_vs_vasco, class: Match do
    association :home_team, factory: :flamengo
    association :away_team, factory: :vasco
    association :championship, factory: :campeonato_carioca
  end

  factory :botafogo_vs_flamengo, class: Match do
    association :home_team, factory: :botafogo
    association :away_team, factory: :flamengo
    association :championship, factory: :campeonato_brasileiro
  end

  factory :fluminense_vs_botafogo, class: Match do
    association :home_team, factory: :fluminense
    association :away_team, factory: :botafogo
    association :championship, factory: :campeonato_brasileiro
  end
end
