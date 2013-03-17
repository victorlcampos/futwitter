FactoryGirl.define do
  factory :news do
    association :team, factory: :flamengo
    image { File.open(File.join(Rails.root, 'spec', 'support', 'image', 'flamengo.jpg')) }
  end
end