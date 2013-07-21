require 'factory_girl'
Dir[Rails.root.join('spec/factories/*.rb')].each { |f| require f }

# globo
FactoryGirl.create(:trusted_domain, name: 'sportv.globo.com')
FactoryGirl.create(:trusted_domain, name: 'globoesporte.com')
FactoryGirl.create(:trusted_domain, name: 'globoesporte.globo.com')

FactoryGirl.create(:trusted_domain, name: 'torcidas.esporte.ig.com.br')
FactoryGirl.create(:trusted_domain, name: 'esporte.uol.com.br')
FactoryGirl.create(:trusted_domain, name: 'esportes.terra.com.br')
FactoryGirl.create(:trusted_domain, name: 'www.espn.com.br')

# Oficiais de times
FactoryGirl.create(:trusted_domain, name: 'www.santosfc.com.br')
FactoryGirl.create(:trusted_domain, name: 'flamengo.com.br')
FactoryGirl.create(:trusted_domain, name: 'www.botafogo.com.br')
