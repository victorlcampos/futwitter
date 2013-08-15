FactoryGirl.define do
  factory :photo do
    sequence(:url) { |n| "http://test.com/#{n}.png" }
  end
end