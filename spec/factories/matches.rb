FactoryGirl.define do
  factory :flamengo_vs_vasco, class: Match do
    association :home_team, factory: :flamengo
    association :away_team, factory: :vasco
  end

  factory :botafogo_vs_flamengo, class: Match do
    association :home_team, factory: :botafogo
    association :away_team, factory: :flamengo
  end

  factory :fluminense_vs_botafogo, class: Match do
    association :home_team, factory: :fluminense
    association :away_team, factory: :botafogo
  end
end
