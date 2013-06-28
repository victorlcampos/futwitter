# encoding: utf-8

FactoryGirl.define do
  factory :move do
    minute 0
    team_name 'Flamengo'
    text 'Começa o jogo'
    association :match, factory: :flamengo_vs_vasco
  end

  factory :flamengo_vs_vasco_move_1, class: Move do
    minute 0
    team_name 'Flamengo'
    text 'Começa o jogo'
    association :match, factory: :flamengo_vs_vasco
  end

  factory :flamengo_vs_vasco_move_2, class: Move do
    minute 35
    team_name 'Vasco'
    text 'Eder Luiz chuta e felipe salva'
    association :match, factory: :flamengo_vs_vasco
  end

end