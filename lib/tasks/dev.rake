namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      load_task("Dropping existing database...") { %x(rails db:drop) }
      load_task("Creating new database...") { %x(rails db:create) }
      load_task("Migrating...") { %x(rails db:migrate) }
      # Seeds
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastro de moedas"
  task add_coins: :environment do 
    load_task("Seeding coins...") do
      coins = [
        {
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://i.pinimg.com/originals/71/9c/3d/719c3dcdd8deeb6dba5f39bfc88da973.png",
          mining_type: MiningType.find_by(acronym: "PoW")
        },
        {
          description: "Ethereum",
          acronym: "ETH",
          url_image: "data:image/png;base64,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",
          mining_type: MiningType.all.sample
        },
        {
          description: "Dashcoin",
          acronym: "DASH",
          url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/660.png",
          mining_type: MiningType.all.sample
        }
      ]
    
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastro de tipos de mineração"
  task add_mining_types: :environment do 
    load_task("Seeding mining types...") do
      mining_types = [
        { description: "Proof of Work", acronym: "PoW", },
        { description: "Proof of Stake", acronym: "PoS", },
        { description: "Proof of Capacity", acronym: "PoC" }
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  def load_task (message)
    spinner = TTY::Spinner.new("[:spinner] #{message}")
    spinner.auto_spin
    yield
    spinner.success()
  end
end


