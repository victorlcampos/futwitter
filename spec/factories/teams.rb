FactoryGirl.define do
  factory :flamengo, class: Team do
    name "Flamengo"
    badge { File.open(File.join(Rails.root, 'spec', 'support', 'image', 'flamengo.jpg')) }
  end

  factory :vasco, class: Team do
    name "Vasco"
    badge { File.open(File.join(Rails.root, 'spec', 'support', 'image', 'vasco.png')) }
  end

  factory :botafogo, class: Team do
    name "Botafogo"
    badge { File.open(File.join(Rails.root, 'spec', 'support', 'image', 'botafogo.png')) }
  end

  factory :fluminense, class: Team do
    name "Fluminense"
    badge { File.open(File.join(Rails.root, 'spec', 'support', 'image', 'fluminense.png')) }
  end
end