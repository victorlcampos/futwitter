# encoding: utf-8

FactoryGirl.define do
  factory :news_flamengo_1, class: News do
    association :team, factory: :flamengo
    image_url do
      File.join(Rails.root, 'spec', 'support', 'image', 'vasco.png')
    end

    title 'Flamengo perde para o vasco'
    url 'http://globo.com/flamengo'
    description 'olaaa mundooo'

    domain_name 'globo'
  end

  factory :news_flamengo_2, class: News do
    association :team, factory: :flamengo
    image_url do
      File.join(Rails.root, 'spec', 'support', 'image',
                                                         'flamengo.jpg')
    end
    title 'Flamengo troca de técnico'
    url 'http://globo.com/flamengo2'
    domain_name 'sportv'
  end
end