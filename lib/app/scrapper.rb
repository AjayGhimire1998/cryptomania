require 'nokogiri'
require 'open-uri'
require 'pastel'
require 'awesome_print'

class Scrapper 
    @@pastel = Pastel.new

    WIKIPEDIA = "https://en.wikipedia.org/wiki/"

    def self.webCryptoName(name)
        doc = get_page("https://en.wikipedia.org/wiki/#{name}")
        history = doc.css("div.mw-body-content.mw-content-ltr div.mw-parser-output p")
        brief_history_title(name.upcase)
        text_iterator(history[0..5])
    end

    def self.brief_history_title(coin_title)
        puts @@pastel.magenta.on_white.bold("
            A Brief on #{coin_title.upcase}...
            ")
    end

    def self.get_page(url)
        html = URI.open(url)
        doc = Nokogiri::HTML(html)
    end

    def self.text_iterator(scrapped_texts)
        scrapped_texts.each do |t|
            puts @@pastel.magenta.on_white.bold(" #{t.text}                   
                ")
        end
    end


    def self.bitcoin_history
        webCryptoName("Bitcoin")
    end

    def self.ethereum_history 
        webCryptoName("Ethereum")
    end

    def self.binancecoin_history 
        webCryptoName("Binancecoin")
    end

    def self.cardano_history 
        webCryptoName("Cardano_(blockchain_platform)")
    end

    def self.ripple_history 
        webCryptoName("Ripple_(payment_protocol)")
    end

    def self.loopring_history 
        webCryptoName("Decentralized_finance")
    end

    def self.dogecoin_history 
        webCryptoName("Dogecoin")
    end

    def self.qtum_history 
       webCryptoName("Quantum")
    end

    def self.tron_history 
        webCryptoName("Tron_(cryptocurrency)")
    end

    def self.litecoin_history 
        webCryptoName("Litecoin")
    end

    def self.decentraland_history 
        webCryptoName("Decentraland")
    end

    def self.bitcoin_gold_history 
       webCryptoName("Bitcoin_Gold")
    end

    def self.iota_history 
        webCryptoName("IOTA_(technology)")
    end

    def self.stellar_history 
      webCryptoName("Stellar_(payment_network)")
    end
    
    def self.monero_history 
        webCryptoName("Monero")
    end
end



