namespace :servidores do
  
  desc "Sincroniza servidores usando a API do portal oxy"
  task sync: :environment do
    service = ServidoresFetcher.new
    service.fetch_and_store
  end

  task sync_salarios: :environment do
    service = ServidoresFetcher.new
    service.fetch_salarios
  end
end
