FactoryGirl.define do
  factory :flamengo, class: Team do
    name 'Flamengo'
    badge do
      File.open(File.join(Rails.root, 'spec', 'support', 'image',
                                                         'flamengo.jpg'))
    end
  end

  factory :vasco, class: Team do
    name 'Vasco'
    badge do
      File.open(File.join(Rails.root, 'spec', 'support', 'image',
                                                         'vasco.png'))
    end
  end

  factory :botafogo, class: Team do
    name 'Botafogo'
    badge do
      File.open(File.join(Rails.root, 'spec', 'support', 'image',
                                                        'botafogo.png'))
    end
  end

  factory :fluminense, class: Team do
    name 'Fluminense'
    badge do
      File.open(File.join(Rails.root, 'spec', 'support', 'image',
                                                         'fluminense.png'))
    end
  end
end