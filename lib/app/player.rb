require 'tty-prompt'
require 'pastel'
require_relative "../../utility/FancyText.rb"
require_relative '../../utility/Crypto_Calculator.rb'
require_relative './crypto_list.rb'
require_relative './invested_crypto.rb'
require_relative './scrapper.rb'
require 'date'
require 'tty-font'

class Player 
    include FancyText::InstanceMethods
    include CryptoCalculator::InstanceMethods

    attr_accessor :name, :balance, :entry_date, :past_crypto_list, :crypto_invested, :exit_date, :exited_crypto_data, :total_balance
    @@all = []
    
    def initialize name="", balance = 10000, entry_date="", past_crypto_list=[], crypto_invested=[], exit_date="", exited_crypto_data = []
        @name = name 
        @balance = balance
        @entry_date = entry_date
        @past_crypto_list = past_crypto_list
        @crypto_invested = crypto_invested
        @exit_date = exit_date
        @exited_crypto_data = exited_crypto_data
        @total_balance = total_balance
        save
    end

    def save 
        @@all << self
    end

    def self.all 
        @@all
    end

    def set_name 
        prompt = TTY::Prompt.new
        @name = prompt.ask("
            Enter Your Player Name: ")
    end

    def set_entry_date 
        pastel = Pastel.new
        prompt = TTY::Prompt.new

        random_year = 2018

        slow_motion(random_year)

        puts pastel.cyan.bold"

            The year selected is #{random_year}
            
            "

        entered_date = prompt.ask(
            " 
            Now, Please type any day in format DD-MM:") do |q|
            q.validate(/([0-2][0-9]|(3)[0-1])[-|\/](((0)[0-9])|((1)[0-2]))/, "Invalid Date Format. TRY AGAIN!" )
        end

        @entry_date = "#{entered_date}-#{random_year}"
    end

    def permission_to_past
        prompt = TTY::Prompt.new
        choices = {yes: 1, no: 2}
        permission = 
            prompt.select("
            Are You Sure You Want To Go Back To #{@entry_date}?", 
            choices)
        
        puts "\n"
        puts "\n"
        
        if permission == choices[:yes]
            progressbar("Travelling to The Past [:bar]", 
                "

            Successfully Travelled Back to #{@entry_date}!!")

            welcome_to_time_message(@entry_date, "make")
        else
            permission_to_past
        end  
    end

    def permission_to_scrape 
        prompt = TTY::Prompt.new
        choices = {learn: 1, proceed: 2}
        permission = 
            prompt.select("
            Do You Want To Learn About Any Currency Before Investing ?", 
            choices)

        puts "\n"
        puts "\n"
        
    
        if permission == choices[:learn]
            real_scrapping
            permission_to_scrape
        else
            InvestedCrypto.select_crypto_to_invest 
        end  
    end

    def real_scrapping 
        prompt = TTY::Prompt.new
        scrapping_permission = 
            prompt.select("
            Please Select the CryptoCurrency You Want to Learn About: ", 
            SCRAPPING_CHOICES)

        puts "\n"
        puts "\n"

        Scrapper.send(scrapping_permission)
  

    end

    def set_exit_date
        pastel = Pastel.new 
        prompt = TTY::Prompt.new

        @exit_date = 
            prompt.ask(
                "
                Please type any day after
            #{@entry_date} and before 31-12-2021 in format DD-MM-YYYY: ") do |q|
            q.validate(/([0-2][0-9]|(3)[0-1])[-|\/](((0)[0-9])|((1)[0-2]))[-|\/]\d{4}/, "Invalid Date Format. TRY AGAIN!" )
        end

        puts "\n"
        puts "\n"

        progressbar("Travelling Back To The Future [:bar]", 
                "

            Successfully Travelled Ahead to #{@exit_date}!!")
        
            welcome_to_time_message(@exit_date, "check on")
    end

    def total_balance_message 
        pastel = Pastel.new
        type_writter("

            The 10,000 AUD you have invested  in #{@entry_date}
            has made the total balance of....

            ")
        slow_motion(pastel.green.bold("#{@total_balance}"))
        type_writter("
            AUD in #{@exit_date}.
            
            ")
    end

end

