require 'pastel'
require 'tty-progressbar'

module FancyText 
    module InstanceMethods

        SCRAPPING_CHOICES = { 
            Bitcoin: "bitcoin_history", 
            Ethereum: "ethereum_history", 
            BinanceCoin: "binancecoin_history", 
            Cardano: "cardano_history", 
            Ripple: "ripple_history", 
            Loopring: "loopring_history", 
            Dogecoin: "dogecoin_history", 
            QTUM: "qtum_history", 
            Tron: "tron_history", 
            Litecoin: "litecoin_history", 
            Decentraland: "decentraland_history", 
            BitcoinGold: "bitcoin_gold_history", 
            IOTA: "iota_history", 
            Stellar: "stellar_history", 
            Monero: "monero_history" 
        }

        CRYPTO_LIST= [
            ["bitcoin", "BTC"],
            ["ethereum", "ETH"],
            ["binancecoin", "BNB"],
            ["cardano", "ADA"],
            ["ripple", "XRP"],
            ["loopring", "LRC"],
            ["dogecoin", "DOGE"],
            ["qtum", "QTM"],
            ["tron", "TRX"],
            ["litecoin", "LTC"],
            ["decentraland", "MANA"],
            ["bitcoin-gold", "BTG"],
            ["iota", "MIOTA"],
            ["stellar", "XLM"],
            ["monero", "XMR"]
        ]

        def type_writter string
            pastel = Pastel.new
            string.each_char do |c|
                print pastel.cyan.bold c
                time_slot = rand(0.009..0.02)
                sleep(time_slot)
            end
        end

        def slow_motion number 
            number.to_s.each_char do |c|
                print c
                time_slot = rand(0.8..1.2)
                sleep(time_slot)
            end
        end

        def progressbar(bar_text, success_message)
            pastel = Pastel.new
            bar = 
            TTY::ProgressBar.new(pastel.cyan.bold(bar_text),
                width: 50)

            130.times do |i|
                sleep(0.03)
                bar.advance
                bar.update(total: 130) if i == 59          
            end
            
            puts pastel.cyan.bold(
                success_message)
        end

        def welcome_to_time_message(date, some_text)
            pastel = Pastel.new
            d = Date.strptime(date.split("-").join(""), '%d%m%Y')
            day = d.strftime('%A')
    
            type_writter("
    
                Alright........what a lovely" )
            print pastel.red.bold(" #{day} ") 
            type_writter("to #{some_text}
                some investments.")
        end
    end
end