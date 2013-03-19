# encoding: utf-8

FactoryGirl.define do
  factory :news_flamengo_1, class: News do
    association :team, factory: :flamengo
    image { File.open(File.join(Rails.root, 'spec', 'support', 'image', 'vasco.png')) }
    title "Flamengo perde para o vasco"
    url "http://globo.com/flamengo"
  end

  factory :news_flamengo_2, class: News do
    association :team, factory: :flamengo
    image { File.open(File.join(Rails.root, 'spec', 'support', 'image', 'flamengo.jpg')) }
    title "Flamengo troca de técnico"
    url "http://globo.com/flamengo2"
  end
end